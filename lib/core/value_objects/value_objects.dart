import 'package:bid_for_cars/core/errors/error.dart';
import 'package:bid_for_cars/core/errors/value_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

/// Export value object files

export 'common.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  bool isValid() => value.isRight();

  /// Throws [UnexpectedValueError] containing the [ValueFailure]
  /// else return the value
  /// note: id (identity) is equal to (r) => r
  T getOrCrash() => value.fold((f) => throw UnexpectedValueError(f), id);

  Either<ValueFailure<dynamic>, Unit> get failureOrUnit {
    return value.fold((l) => Left(l), (r) => const Right(unit));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
