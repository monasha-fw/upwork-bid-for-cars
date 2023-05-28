import 'package:bid_for_cars/core/value_objects/common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required FirstName firstName,
    required LastName lastName,
    required EmailAddress email,
  }) = _User;
}
