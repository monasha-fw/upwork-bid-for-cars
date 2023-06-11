import 'package:bid_for_cars/core/dtos/auth/token_refresh_dto.dart';
import 'package:bid_for_cars/core/errors/auth_failures.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/extensions/dartz.dart';
import 'package:bid_for_cars/infrastructure/constants/endpoint_urls.dart';
import 'package:bid_for_cars/infrastructure/datasources/local_datasource/auth_local_datasource.dart';
import 'package:bid_for_cars/infrastructure/datasources/remote_datasource/auth_remote_datasource.dart';
import 'package:bid_for_cars/presentation/extensions/failure.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

/// will bypass accessToken check on these urls
const noneAuthedRoute = [
  EndpointUrls.loginUserEmail,
  EndpointUrls.registerUserEmail,
  EndpointUrls.forgottenPasswordResetRequest,
  EndpointUrls.resetPassword,
  EndpointUrls.resendVerificationCode,
];

class DioInterceptor extends Interceptor {
  final AuthLocalDatasource _authLocalDatasource;
  final AuthRemoteDatasource _authRemoteDatasource;

  DioInterceptor(this._authLocalDatasource, this._authRemoteDatasource);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // super.onRequest(options, handler);
    /// check if the [accessToken] is already appended to the headers
    final hasAccessToken =
        options.headers.containsKey('Authorization') && options.headers['Authorization'] != null;

    final mustHaveAuth = !noneAuthedRoute.any((x) => options.path == x);
    if (mustHaveAuth && !hasAccessToken) {
      var exception = DioException(requestOptions: options, type: DioExceptionType.unknown);

      var cachedUserEither = await _authLocalDatasource.getCachedAuthTokens();
      if (cachedUserEither.isLeft()) {
        /// on failure to retrieve the cache from the device
        return handler.reject(
          exception.copyWith(
            error: cachedUserEither.asLeft.getMessage,
            message: cachedUserEither.asLeft.getMessage,
          ),
        );
      }

      var cachedToken = cachedUserEither.asRight;
      if (JwtDecoder.isExpired(cachedToken.accessToken)) {
        var errorMessage = const Failure.authFailure(AuthFailure.tokenExpired()).getMessage;

        /// when [refreshToken] doesn't exist in the cache, reject the request
        if (cachedUserEither.asRight.refreshToken == null) {
          return handler.reject(exception.copyWith(error: errorMessage, message: errorMessage));
        }

        /// accessToken has expired, refresh from here
        final refreshDto = TokenRefreshDto(
          accessToken: cachedUserEither.asRight.accessToken,
          refreshToken: cachedUserEither.asRight.refreshToken!,
        );

        final refreshEither = await _authRemoteDatasource.refreshAccessToken(refreshDto);

        /// if refresh failed for the [authTokens], reject the request
        if (refreshEither.isLeft()) {
          errorMessage = refreshEither.asLeft.getMessage;
          return handler.reject(exception.copyWith(error: errorMessage, message: errorMessage));
        }

        /// save new [authTokens]
        final newTokens = refreshEither.asRight;
        _authLocalDatasource.cachedAuthTokens(newTokens);

        /// update the cached tokens value with new [authTokens]
        cachedToken = newTokens;
      }

      /// append the [accessToken] to header
      options.headers = {"Authorization": "Bearer ${cachedToken.accessToken}"};
    }
    return handler.next(options);
  }
}
