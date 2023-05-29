import 'package:bid_for_cars/core/dtos/car/get_cars_dto.dart';
import 'package:bid_for_cars/core/entities/car_thumbnail.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/repositories/i_car_repository.dart';
import 'package:bid_for_cars/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetCars implements Usecase<List<CarThumbnail>, GetCarsDto> {
  final ICarRepository repository;

  const GetCars(this.repository);

  @override
  Future<Either<Failure, List<CarThumbnail>>> call(GetCarsDto dto) async {
    return repository.getCars(dto);
  }
}
