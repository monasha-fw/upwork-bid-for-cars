import 'package:bid_for_cars/core/dtos/auth/email_register_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_register_model_dto.freezed.dart';
part 'email_register_model_dto.g.dart';

@freezed
class EmailRegisterModelDto with _$EmailRegisterModelDto {
  const EmailRegisterModelDto._();

  const factory EmailRegisterModelDto({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) = _EmailRegisterModelDto;

  factory EmailRegisterModelDto.fromJson(Map<String, dynamic> json) =>
      _$EmailRegisterModelDtoFromJson(json);

  factory EmailRegisterModelDto.fromDomain(EmailRegisterDto params) {
    return EmailRegisterModelDto(
      firstName: params.firstName.getOrCrash(),
      lastName: params.lastName.getOrCrash(),
      email: params.email.getOrCrash(),
      password: params.password.getOrCrash(),
    );
  }
}
