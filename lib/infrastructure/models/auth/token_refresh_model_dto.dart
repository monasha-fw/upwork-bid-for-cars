import 'package:bid_for_cars/core/dtos/auth/token_refresh_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_refresh_model_dto.freezed.dart';
part 'token_refresh_model_dto.g.dart';

@freezed
class TokenRefreshModelDto with _$TokenRefreshModelDto {
  const factory TokenRefreshModelDto({
    required String accessToken,
    required String? refreshToken,
  }) = _TokenRefreshModelDto;

  factory TokenRefreshModelDto.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshModelDtoFromJson(json);

  factory TokenRefreshModelDto.fromDomain(TokenRefreshDto dto) {
    return TokenRefreshModelDto(
      accessToken: dto.accessToken,
      refreshToken: dto.refreshToken,
    );
  }
}
