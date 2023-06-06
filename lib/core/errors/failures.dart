import 'package:freezed_annotation/freezed_annotation.dart';

import 'cache_failures.dart';
import 'network_failure.dart';

part 'failures.freezed.dart';

@freezed
class Failure<T> with _$Failure<T> {
  /// General failures
  const factory Failure.ignoringFailure() = IgnoringFailure;

  const factory Failure.formatException() = FormatException;

  const factory Failure.unableToProcess(dynamic error) = UnableToProcess;

  const factory Failure.unexpectedError(String message) = UnexpectedError;

  /// Nested failures
  const factory Failure.networkFailure(NetworkFailure f) = _NetworkFailure;

  const factory Failure.cacheFailure(CacheFailure f) = _CacheFailure;
}
