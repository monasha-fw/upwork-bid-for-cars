import 'package:bid_for_cars/core/dtos/auth/password_reset_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_reset_model_dto.freezed.dart';
part 'password_reset_model_dto.g.dart';

@freezed
class PasswordResetModelDto with _$PasswordResetModelDto {
  const PasswordResetModelDto._();

  const factory PasswordResetModelDto({
    required String email,
    required String code,
    required String password,
  }) = _PasswordResetModelDto;

  factory PasswordResetModelDto.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetModelDtoFromJson(json);

  factory PasswordResetModelDto.fromDomain(PasswordResetDto params) {
    return PasswordResetModelDto(
      email: params.email.getOrCrash(),
      code: params.code.getOrCrash(),
      password: params.password.getOrCrash(),
    );
  }
}
