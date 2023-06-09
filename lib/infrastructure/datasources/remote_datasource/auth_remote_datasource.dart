import 'package:bid_for_cars/core/dtos/auth/email_login_dto.dart';
import 'package:bid_for_cars/core/dtos/auth/email_register_dto.dart';
import 'package:bid_for_cars/core/dtos/auth/password_reset_dto.dart';
import 'package:bid_for_cars/core/dtos/auth/token_refresh_dto.dart';
import 'package:bid_for_cars/core/entities/auth_tokens.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/value_objects/value_objects.dart';
import 'package:bid_for_cars/infrastructure/constants/endpoint_urls.dart';
import 'package:bid_for_cars/infrastructure/dtos/auth/email_login_model_dto.dart';
import 'package:bid_for_cars/infrastructure/dtos/auth/email_register_model_dto.dart';
import 'package:bid_for_cars/infrastructure/dtos/auth/password_reset_model_dto.dart';
import 'package:bid_for_cars/infrastructure/errors/app_exceptions.dart';
import 'package:bid_for_cars/infrastructure/models/auth/auth_tokens_response_model.dart';
import 'package:bid_for_cars/infrastructure/models/auth/token_refresh_model_dto.dart';
import 'package:bid_for_cars/infrastructure/network/http_client.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDatasource {
  /// Login using email address
  ///
  /// [EmailLoginDto] containing [email] and [password]
  Future<Either<Failure, AuthTokens>> loginUserEmail(EmailLoginDto dto);

  /// Create an account using a email address
  ///
  /// [EmailRegisterDto] containing [firstName], [lastName], [email] and [password]
  Future<Either<Failure, Unit>> registerUserEmail(EmailRegisterDto dto);

  /// Request for a password reset using [email]
  ///
  /// [email] related to the account
  Future<Either<Failure, Unit>> requestPasswordReset(EmailAddress email);

  /// Change forgotten password
  ///
  /// [email], [password] and the [verificationCode]
  Future<Either<Failure, Unit>> resetPassword(PasswordResetDto dto);

  /// Re-Sends the [verificationToken]
  ///
  /// [email] related to the account
  Future<Either<Failure, Unit>> resendVerificationCode(EmailAddress email);

  /// Refreshes [accessToken] and [refreshToken]
  ///
  /// [refreshDto] containing expired [accessToken] and the valid [refreshToken]
  /// on success, returns renewed [AuthTokens]
  Future<Either<Failure, AuthTokens>> refreshAccessToken(TokenRefreshDto refreshDto);
}

@Singleton(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final AppHttpClient client;

  AuthRemoteDatasourceImpl(this.client);

  @override
  Future<Either<Failure, AuthTokens>> loginUserEmail(EmailLoginDto dto) async {
    try {
      final data = EmailLoginModelDto.fromDomain(dto).toJson();
      const url = EndpointUrls.loginUserEmail;

      final response = await client.post(url, data: data);

      /// extract the new [AuthTokens] from the json response
      final tokens = AuthTokensResponseModel.fromJson(response.data).toAuthTokens();

      return Right(tokens);
    } catch (e) {
      return Left(AppExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> registerUserEmail(EmailRegisterDto dto) async {
    try {
      final data = EmailRegisterModelDto.fromDomain(dto).toJson();
      const url = EndpointUrls.registerUserEmail;

      await client.post(url, data: data);

      return const Right(unit);
    } catch (e) {
      return Left(AppExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> requestPasswordReset(EmailAddress email) async {
    try {
      const url = EndpointUrls.forgottenPasswordResetRequest;

      await client.post(url, data: {"email": email.getOrCrash()});

      return const Right(unit);
    } catch (e) {
      return Left(AppExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPassword(PasswordResetDto dto) async {
    try {
      final data = PasswordResetModelDto.fromDomain(dto).toJson();
      const url = EndpointUrls.resetPassword;

      await client.post(url, data: data);

      return const Right(unit);
    } catch (e) {
      return Left(AppExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> resendVerificationCode(EmailAddress email) async {
    try {
      const url = EndpointUrls.resendVerificationCode;

      await client.post(url, data: {"email": email.getOrCrash()});

      return const Right(unit);
    } catch (e) {
      return Left(AppExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, AuthTokens>> refreshAccessToken(TokenRefreshDto dto) async {
    try {
      const url = EndpointUrls.refreshTokens;
      final data = TokenRefreshModelDto.fromDomain(dto).toJson();

      final response = await client.post(url, data: data);

      /// extract the new [AuthTokens] from the json response
      final tokens = AuthTokensResponseModel.fromJson(response.data).toAuthTokens();

      return Right(tokens);
    } catch (e) {
      return Left(AppExceptions.exceptionToFailure(e));
    }
  }
}
