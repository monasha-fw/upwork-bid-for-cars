import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/value_objects/common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String firstName,
    required String lastName,
    required String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  User toDomain() {
    return User(
      firstName: FirstName(firstName),
      lastName: LastName(lastName),
      email: EmailAddress(email),
    );
  }
}
