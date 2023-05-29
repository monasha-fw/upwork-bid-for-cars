import 'package:bid_for_cars/core/dtos/car/get_cars_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_cars_model_dto.freezed.dart';
part 'get_cars_model_dto.g.dart';

@freezed
class GetCarsModelDto with _$GetCarsModelDto {
  const GetCarsModelDto._();

  const factory GetCarsModelDto({
    required int limit,
    required int page,
    String? status,
  }) = _GetCarsModelDto;

  factory GetCarsModelDto.fromJson(Map<String, dynamic> json) => _$GetCarsModelDtoFromJson(json);

  factory GetCarsModelDto.fromDomain(GetCarsDto params) {
    return GetCarsModelDto(
      limit: params.pagination.limit,
      page: params.pagination.page,
      status: params.status?.name,
    );
  }
}
