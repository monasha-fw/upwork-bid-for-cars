import 'package:freezed_annotation/freezed_annotation.dart';

part 'cache_failures.freezed.dart';

@freezed
class CacheFailure with _$CacheFailure {
  const factory CacheFailure.cacheClearFailure({String? message}) = CacheClearFailure;

  const factory CacheFailure.cacheSetFailure({String? message}) = CacheSetFailure;

  const factory CacheFailure.cacheGetFailure({String? message}) = CacheGetFailure;
}
