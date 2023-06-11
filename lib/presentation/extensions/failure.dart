import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/i18n/translations.g.dart';

extension FailuresMapper on Failure {
  String get getMessage => map(
        authFailure: (af) => af.f.map(
          tokenExpired: (_) => t.common.errors.authFailures.tokenExpired,
        ),
        unexpectedError: (sf) => sf.message,
        cacheFailure: (cf) => cf.f.map(
          cacheClearFailure: (f) => f.message ?? t.common.errors.cacheFailure,
          cacheSetFailure: (f) => f.message ?? t.common.errors.cacheFailure,
          cacheGetFailure: (f) => f.message ?? t.common.errors.cacheFailure,
        ),
        networkFailure: (nf) => nf.f.map(
          // TODO - Add rest of error messages to translations
          requestCancelled: (f) => t.common.errors.somethingWentWrong,
          unauthorisedRequest: (f) => f.errorMessage ?? t.common.errors.unauthorized,
          badRequest: (f) => t.common.errors.somethingWentWrong,
          notFound: (f) => f.error.toString(),
          methodNotAllowed: (f) => t.common.errors.somethingWentWrong,
          notAcceptable: (f) => t.common.errors.somethingWentWrong,
          requestTimeout: (f) => t.common.errors.somethingWentWrong,
          conflict: (f) => t.common.errors.somethingWentWrong,
          internalServerError: (f) => t.common.errors.somethingWentWrong,
          notImplemented: (f) => t.common.errors.somethingWentWrong,
          serviceUnavailable: (f) => t.common.errors.somethingWentWrong,
          connectionRefused: (f) => t.common.errors.somethingWentWrong,
          noInternetConnection: (f) => t.common.errors.somethingWentWrong,
          defaultError: (f) => f.error,
          unexpectedError: (f) => f.data.toString(),
          badCertificate: (f) => t.common.errors.somethingWentWrong,
          badResponse: (f) => t.common.errors.somethingWentWrong,
          connectionError: (f) => t.common.errors.somethingWentWrong,
        ),
        ignoringFailure: (_) => "",
        formatException: (fe) => fe.exception.message,
        unableToProcess: (uf) => uf.error,
      );
}
