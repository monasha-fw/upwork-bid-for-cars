import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_model.dart';

part 'login_response_model.freezed.dart';
part 'login_response_model.g.dart';

@freezed
class LoginResponseModel with _$LoginResponseModel {
  const LoginResponseModel._();

  const factory LoginResponseModel({
    @JsonKey(name: 'access_token') required String accessToken,
  }) = _LoginResponseModel;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  UserModel toUserModel() {
    JWT decoded = JWT.decode(accessToken);
    Map<String, dynamic> decodedPayload = decoded.payload;
    return UserModel.fromJson(decodedPayload);
  }
}
