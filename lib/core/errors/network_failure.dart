import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_failure.freezed.dart';

@freezed
class NetworkFailure with _$NetworkFailure {
  const factory NetworkFailure.requestCancelled() = RequestCancelled;

  const factory NetworkFailure.unauthorisedRequest(String? errorMessage) = UnauthorisedRequest;

  const factory NetworkFailure.badCertificate() = BadCertificate;

  const factory NetworkFailure.badRequest() = BadRequest;

  const factory NetworkFailure.badResponse() = BadResponse;

  const factory NetworkFailure.connectionError() = ConnectionError;

  const factory NetworkFailure.notFound(dynamic error) = NotFound;

  const factory NetworkFailure.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkFailure.notAcceptable() = NotAcceptable;

  const factory NetworkFailure.requestTimeout() = RequestTimeout;

  const factory NetworkFailure.conflict() = Conflict;

  const factory NetworkFailure.internalServerError() = InternalServerError;

  const factory NetworkFailure.notImplemented() = NotImplemented;

  const factory NetworkFailure.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkFailure.connectionRefused() = ConnectionRefused;

  const factory NetworkFailure.noInternetConnection() = NoInternetConnection;

  const factory NetworkFailure.defaultError(String error) = DefaultError;

  const factory NetworkFailure.unexpectedError(dynamic data) = UnexpectedError;
}
