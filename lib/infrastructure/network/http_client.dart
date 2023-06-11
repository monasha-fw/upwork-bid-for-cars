import 'dart:io';

import 'package:bid_for_cars/i18n/translations.g.dart';
import 'package:bid_for_cars/infrastructure/constants/endpoint_urls.dart';
import 'package:bid_for_cars/infrastructure/mocks/mocks.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:injectable/injectable.dart';

import 'i_http_client.dart';
import 'network_info.dart';

/// will bypass accessToken check on these urls
const noneAuthedRoute = [
  EndpointUrls.loginUserEmail,
];

@injectable
class AppHttpClient implements IHttpClient {
  final Dio dio;
  final INetworkInfo networkInfo;
  final DioAdapter dioAdapter;

  AppHttpClient(
    this.dio,
    this.networkInfo,
    this.dioAdapter,
  ) {
    dio
      ..httpClientAdapter

      /// TODO - Mocks only for testing without a server
      ..httpClientAdapter = dioAdapter;
    MockingData().init(dioAdapter);

    /// TODO refresh token interceptor
    // dio.interceptors.add(
    //   QueuedInterceptorsWrapper(
    //     onRequest: (options, handler) async {
    //       /// check if the token is appended from the datasource function
    //       return handler.next(options);
    //     },
    //   ),
    // );
  }

  @override
  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (!(await networkInfo.isConnected)) {
      throw SocketException(t.common.errors.noInternet);
    }

    try {
      var newOptions = options ?? Options(contentType: Headers.jsonContentType);

      Response response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: newOptions,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> checkInternetConnectivity() async {
    if (!(await networkInfo.isConnected)) {
      throw SocketException(t.common.errors.noInternet);
    }
  }

  @override
  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    await checkInternetConnectivity();

    try {
      var newOptions = options ?? Options(contentType: Headers.jsonContentType);

      Response response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: newOptions,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> delete(
    String uri, {
    Map<String, dynamic>? queryParameters,
    data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    if (!(await networkInfo.isConnected)) {
      throw SocketException(t.common.errors.noInternet);
    }

    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> patch(
    String uri, {
    Map<String, dynamic>? queryParameters,
    data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) async {
    if (!(await networkInfo.isConnected)) {
      throw SocketException(t.common.errors.noInternet);
    }

    try {
      var response = await dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> put(
    String uri, {
    Map<String, dynamic>? queryParameters,
    data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) async {
    if (!(await networkInfo.isConnected)) {
      throw SocketException(t.common.errors.noInternet);
    }

    try {
      var response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      rethrow;
    }
  }
}
