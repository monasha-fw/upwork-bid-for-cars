import 'package:bid_for_cars/core/dtos/auth/email_login_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_login_model_dto.freezed.dart';
part 'email_login_model_dto.g.dart';

@freezed
class EmailLoginModelDto with _$EmailLoginModelDto {
  const EmailLoginModelDto._();

  const factory EmailLoginModelDto({
    required String email,
    required String password,
  }) = _EmailLoginModelDto;

  factory EmailLoginModelDto.fromJson(Map<String, dynamic> json) =>
      _$EmailLoginModelDtoFromJson(json);

  factory EmailLoginModelDto.fromDomain(EmailLoginDto params) {
    return EmailLoginModelDto(
      email: params.email.getOrCrash(),
      password: params.password.getOrCrash(),
    );
  }
}
