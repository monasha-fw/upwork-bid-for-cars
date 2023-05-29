import 'package:bid_for_cars/core/enums/car.dart';
import 'package:bid_for_cars/core/options/get_pagination.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_cars_dto.freezed.dart';

@freezed
class GetCarsDto with _$GetCarsDto {
  const factory GetCarsDto({
    required GetPagination pagination,
    CarStatusEnum? status,
  }) = _GetCarsDto;
}
