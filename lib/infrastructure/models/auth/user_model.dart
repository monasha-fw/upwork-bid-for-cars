import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/value_objects/common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    @JsonKey(name: 'sub') required String id,
    required String firstName,
    required String lastName,
    required String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  factory UserModel.fromDomain(User user) {
    return UserModel(
      id: user.id.getOrCrash(),
      firstName: user.firstName.getOrCrash(),
      lastName: user.lastName.getOrCrash(),
      email: user.email.getOrCrash(),
    );
  }

  User toDomain() {
    return User(
      id: UserId(id),
      firstName: FirstName(firstName),
      lastName: LastName(lastName),
      email: EmailAddress(email),
    );
  }
}
