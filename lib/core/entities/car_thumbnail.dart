import 'package:bid_for_cars/core/enums/car.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'car_thumbnail.freezed.dart';

@freezed
class CarThumbnail with _$CarThumbnail {
  const factory CarThumbnail({
    required String id,
    required String name,
    required String image,
    required String mileage,
    required String location,
    required String engineCapacity,
    required CarStatusEnum status,
    required double? highestBid,
    required String currency,
    required DateTime expiresIn,
  }) = _CarThumbnail;
}
