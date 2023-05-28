import 'package:freezed_annotation/freezed_annotation.dart';

part 'exceptions.freezed.dart';

@freezed
class Exception with _$Exception {
  const factory Exception.otherException() = OtherException;

  // const factory Exception.networkException() = NetworkException;

  const factory Exception.cacheException() = CacheException;
}
