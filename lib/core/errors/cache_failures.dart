import 'package:freezed_annotation/freezed_annotation.dart';

part 'cache_failures.freezed.dart';

@freezed
class CacheFailure with _$CacheFailure {
  const factory CacheFailure.cacheClearFailure(
      {@Default("Failed to clear data from device") String message}) = CacheClearFailure;

  const factory CacheFailure.cacheSetFailure(
      {@Default("Failed to save data to device") String message}) = CacheSetFailure;

  const factory CacheFailure.cacheGetFailure(
      {@Default("Failed to retrieve data from device") String message}) = CacheGetFailure;
}
