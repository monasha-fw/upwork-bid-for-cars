import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_refresh_dto.freezed.dart';

@freezed
class TokenRefreshDto with _$TokenRefreshDto {
  const factory TokenRefreshDto({
    // TODO - to value objects
    required String accessToken,
    required String refreshToken,
  }) = _TokenRefreshDto;
}
