import 'package:freezed_annotation/freezed_annotation.dart';

import 'network_failure.dart';

part 'failures.freezed.dart';

@freezed
class Failure<T> with _$Failure<T> {
  /// Sub failures
  const factory Failure.networkFailure(NetworkFailure f) = _NetworkFailure;

  /// Common failures
  const factory Failure.cacheClearFailure(
      {@Default("Failed to clear data from device") String message}) = CacheClearFailure;

  const factory Failure.cacheSetFailure(
      {@Default("Failed to save data to device") String message}) = CacheSetFailure;

  const factory Failure.cacheGetFailure(
      {@Default("Failed to retrieve data from device") String message}) = CacheGetFailure;

  const factory Failure.ignoringFailure() = IgnoringFailure;

  const factory Failure.formatException() = FormatException;

  const factory Failure.unableToProcess(dynamic error) = UnableToProcess;

  const factory Failure.unexpectedError(String message) = UnexpectedError;
}
