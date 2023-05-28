import 'package:bid_for_cars/core/value_objects/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_register_dto.freezed.dart';

@freezed
class EmailRegisterDto with _$EmailRegisterDto {
  const factory EmailRegisterDto({
    required FirstName firstName,
    required LastName lastName,
    required EmailAddress email,
    required Password password,
  }) = _EmailRegisterDto;
}
