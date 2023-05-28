import 'dart:developer';
import 'dart:io';

import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/errors/network_failure.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exceptions.freezed.dart';

@freezed
class AppExceptions with _$AppExceptions {
  const AppExceptions._();

  const factory AppExceptions() = _AppExceptions;

  static Failure exceptionToFailure(error) {
    log("[FAILURE] $error");
    if (error is PlatformException) {
      return _getPlatformException(error);
    } else if (error is Exception) {
      try {
        return Failure.networkFailure(_getDioException(error));
      } on FormatException catch (_) {
        return const Failure.formatException();
      } catch (ex) {
        return Failure.unexpectedError(ex.toString());
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return Failure.unableToProcess(error);
      } else {
        return Failure.unexpectedError(error);
      }
    }
  }

  static Failure _getPlatformException(error) {
    late Failure failure;
    switch (error.code) {
      // case "sign_in_failed":
      //   failure = Failure.authFailure(AuthFailure.somethingWentWrong(message: t.errors.failures.auth.googleSignIn));
      //   break;
      default:
        failure = Failure.unexpectedError(error);
    }
    return failure;
  }

  static NetworkFailure _getDioException(error) {
    late NetworkFailure networkFailure;
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          networkFailure = const NetworkFailure.requestCancelled();
          break;
        case DioErrorType.connectTimeout:
          networkFailure = const NetworkFailure.requestTimeout();
          break;
        case DioErrorType.other:
          networkFailure = const NetworkFailure.connectionRefused();
          break;
        case DioErrorType.receiveTimeout:
          networkFailure = const NetworkFailure.sendTimeout();
          break;
        case DioErrorType.response:
          switch (error.response?.statusCode) {
            case 400:
              networkFailure = NetworkFailure.unauthorisedRequest(error.response?.data);
              break;
            case 401:
              networkFailure = NetworkFailure.unauthorisedRequest(error.response?.data);
              break;
            case 403:
              networkFailure = NetworkFailure.unauthorisedRequest(error.response?.data);
              break;
            case 404:
              networkFailure = NetworkFailure.notFound(error);
              break;
            case 409:
              networkFailure = const NetworkFailure.conflict();
              break;
            case 408:
              networkFailure = const NetworkFailure.requestTimeout();
              break;
            case 500:
              networkFailure = const NetworkFailure.internalServerError();
              break;
            case 503:
              networkFailure = const NetworkFailure.serviceUnavailable();
              break;
            default:
              int? responseCode = error.response?.statusCode;
              networkFailure =
                  NetworkFailure.defaultError("Received invalid status code: $responseCode");
          }
          break;
        case DioErrorType.sendTimeout:
          networkFailure = const NetworkFailure.sendTimeout();
          break;
      }
    } else if (error is SocketException) {
      networkFailure = const NetworkFailure.noInternetConnection();
    } else {
      networkFailure = NetworkFailure.unexpectedError(error);
    }
    return networkFailure;
  }
}
