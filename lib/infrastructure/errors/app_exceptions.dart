import 'dart:developer';
import 'dart:io';

import 'package:bid_for_cars/core/errors/error.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/errors/network_failure.dart';
import 'package:bid_for_cars/i18n/translations.g.dart';
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
    if (error is UnexpectedValueError) {
      return Failure.unableToProcess(
        error.valueFailure.failedValue?.toString() ?? t.common.errors.somethingWentWrong,
      );
    } else if (error is PlatformException) {
      return _getPlatformException(error);
    } else if (error is Exception) {
      try {
        return Failure.networkFailure(_getDioException(error));
      } on FormatException catch (e) {
        return Failure.formatException(e);
      } catch (ex) {
        return Failure.unexpectedError(ex.toString());
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return Failure.unableToProcess(error.toString());
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
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          networkFailure = const NetworkFailure.requestTimeout();
          break;
        case DioExceptionType.badCertificate:
          networkFailure = const NetworkFailure.badCertificate();
          break;
        case DioExceptionType.badResponse:
          networkFailure = const NetworkFailure.badResponse();
          break;
        case DioExceptionType.cancel:
          networkFailure = const NetworkFailure.requestCancelled();
          break;
        case DioExceptionType.connectionError:
          networkFailure = const NetworkFailure.connectionError();
          break;
        case DioExceptionType.unknown:
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
      }
    } else if (error is SocketException) {
      networkFailure = const NetworkFailure.noInternetConnection();
    } else {
      networkFailure = NetworkFailure.unexpectedError(error);
    }
    return networkFailure;
  }
}
