import 'package:bid_for_cars/core/dtos/car/get_cars_dto.dart';
import 'package:bid_for_cars/core/entities/car_thumbnail.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/repositories/i_car_repository.dart';
import 'package:bid_for_cars/infrastructure/datasources/remote_datasource/car_remote_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ICarRepository)
class CarRepositoryImpl implements ICarRepository {
  final CarRemoteDataSource remoteDataSource;

  const CarRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CarThumbnail>>> getCars(GetCarsDto dto) {
    return remoteDataSource.getCars(dto);
  }
}
