import 'package:bid_for_cars/core/entities/auth_tokens.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_model.dart';

part 'auth_tokens_response_model.freezed.dart';
part 'auth_tokens_response_model.g.dart';

@freezed
class AuthTokensResponseModel with _$AuthTokensResponseModel {
  const AuthTokensResponseModel._();

  const factory AuthTokensResponseModel({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') String? refreshToken,
  }) = _AuthTokensResponseModel;

  factory AuthTokensResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensResponseModelFromJson(json);

  UserModel toUserModel() {
    JWT decoded = JWT.decode(accessToken);
    Map<String, dynamic> decodedPayload = decoded.payload;
    return UserModel.fromJson(decodedPayload);
  }

  AuthTokens toAuthTokens() {
    return AuthTokens(accessToken: accessToken, refreshToken: refreshToken);
  }
}
