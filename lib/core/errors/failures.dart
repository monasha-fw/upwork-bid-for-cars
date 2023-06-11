import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_failures.dart';
import 'cache_failures.dart';
import 'network_failure.dart';

part 'failures.freezed.dart';

@freezed
class Failure<T> with _$Failure<T> {
  /// General failures
  const factory Failure.ignoringFailure() = _IgnoringFailure;

  const factory Failure.formatException(FormatException exception) = _FormatException;

  const factory Failure.unableToProcess(String error) = _UnableToProcess;

  const factory Failure.unexpectedError(String message) = _UnexpectedError;

  /// Nested failures
  const factory Failure.authFailure(AuthFailure f) = _AuthFailure;

  const factory Failure.networkFailure(NetworkFailure f) = _NetworkFailure;

  const factory Failure.cacheFailure(CacheFailure f) = _CacheFailure;
}
