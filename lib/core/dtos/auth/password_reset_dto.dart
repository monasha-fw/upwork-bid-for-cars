import 'package:bid_for_cars/core/value_objects/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_reset_dto.freezed.dart';

@freezed
class PasswordResetDto with _$PasswordResetDto {
  const factory PasswordResetDto({
    required EmailAddress email,
    required VerificationCode code,
    required Password password,
  }) = _PasswordResetDto;
}
