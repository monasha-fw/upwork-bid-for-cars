import 'package:bid_for_cars/core/value_objects/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_login_dto.freezed.dart';

@freezed
class EmailLoginDto with _$EmailLoginDto {
  const factory EmailLoginDto({
    required EmailAddress email,
    required Password password,
  }) = _EmailLoginDto;
}
