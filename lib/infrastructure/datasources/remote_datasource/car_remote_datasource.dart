import 'package:bid_for_cars/core/dtos/car/get_cars_dto.dart';
import 'package:bid_for_cars/core/entities/car_thumbnail.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/infrastructure/constants/endpoint_urls.dart';
import 'package:bid_for_cars/infrastructure/dtos/car/get_cars_model_dto.dart';
import 'package:bid_for_cars/infrastructure/errors/app_exceptions.dart';
import 'package:bid_for_cars/infrastructure/models/car/car_thumbnail_model.dart';
import 'package:bid_for_cars/infrastructure/network/http_client.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class CarRemoteDataSource {
  /// Get cars
  ///
  /// [GetCarsDto] must contain,  [CarStatusEnum] and [GetPagination] objects
  Future<Either<Failure, List<CarThumbnail>>> getCars(GetCarsDto dto);
}

@Singleton(as: CarRemoteDataSource)
class CarRemoteDataSourceImpl implements CarRemoteDataSource {
  final AppHttpClient client;

  CarRemoteDataSourceImpl(this.client);

  @override
  Future<Either<Failure, List<CarThumbnail>>> getCars(GetCarsDto dto) async {
    try {
      final params = GetCarsModelDto.fromDomain(dto).toJson();
      const url = EndpointUrls.getCars;

      final response = await client.get(url, queryParameters: params);

      final listJson = List<Map<String, dynamic>>.from(response.data);
      final list = listJson.map((c) => CarThumbnailModel.fromJson(c).toDomain()).toList();

      return Right(list);
    } catch (e) {
      return Left(AppExceptions.exceptionToFailure(e));
    }
  }
}
