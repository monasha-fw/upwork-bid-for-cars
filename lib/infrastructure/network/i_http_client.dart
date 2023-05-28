import 'package:dio/dio.dart';

abstract class IHttpClient {
  /// Http method for [GET] request
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  });

  /// Http method for [POST] request
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  /// Http method for [PATCH] request
  Future<dynamic> patch(
    String uri, {
    Map<String, dynamic>? queryParameters,
    data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  });

  /// Http method for [PUT] request
  Future<dynamic> put(
    String uri, {
    Map<String, dynamic>? queryParameters,
    data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  });

  /// Http method for [DELETE] request
  Future<dynamic> delete(
    String uri, {
    Map<String, dynamic>? queryParameters,
    data,
    Options? options,
    CancelToken? cancelToken,
  });
}
