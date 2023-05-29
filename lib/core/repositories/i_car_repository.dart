import 'package:bid_for_cars/core/dtos/car/get_cars_dto.dart';
import 'package:bid_for_cars/core/entities/car_thumbnail.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ICarRepository {
  /// Get cars
  ///
  /// [GetCarsDto] must contain,  [CarStatusEnum] and [GetPagination] objects
  Future<Either<Failure, List<CarThumbnail>>> getCars(GetCarsDto dto);
}
