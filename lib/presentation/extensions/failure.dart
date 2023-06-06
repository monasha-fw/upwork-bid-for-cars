import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/i18n/translations.g.dart';

extension FailuresMapper on Failure {
  String get getMessage => maybeMap(
        unexpectedError: (sf) => sf.message,
        cacheFailure: (cf) => cf.f.map(
          cacheClearFailure: (f) => f.message,
          cacheSetFailure: (f) => f.message,
          cacheGetFailure: (f) => f.message,
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
          sendTimeout: (f) => t.common.errors.somethingWentWrong,
          conflict: (f) => t.common.errors.somethingWentWrong,
          internalServerError: (f) => t.common.errors.somethingWentWrong,
          notImplemented: (f) => t.common.errors.somethingWentWrong,
          serviceUnavailable: (f) => t.common.errors.somethingWentWrong,
          connectionRefused: (f) => t.common.errors.somethingWentWrong,
          noInternetConnection: (f) => t.common.errors.somethingWentWrong,
          defaultError: (f) => f.error,
          unexpectedError: (f) => f.data.toString(),
        ),
        // TODO - add all the errors
        orElse: () => t.common.errors.somethingWentWrong,
      );
}
