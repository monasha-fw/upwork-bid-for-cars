import 'package:bid_for_cars/core/entities/car_thumbnail.dart';
import 'package:bid_for_cars/core/enums/car.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'car_thumbnail_model.freezed.dart';
part 'car_thumbnail_model.g.dart';

@freezed
class CarThumbnailModel with _$CarThumbnailModel {
  const CarThumbnailModel._();

  const factory CarThumbnailModel({
    required String id,
    required String name,
    required String image,
    required String mileage,
    required String location,
    required String engineCapacity,
    required String status,
    required double? highestBid,
    required String currency,
    required DateTime expiresIn,
  }) = _CarThumbnailModel;

  factory CarThumbnailModel.fromJson(Map<String, dynamic> json) =>
      _$CarThumbnailModelFromJson(json);

  CarThumbnail toDomain() {
    // TODO - change to value objects
    return CarThumbnail(
      id: id,
      name: name,
      image: image,
      mileage: mileage,
      location: location,
      engineCapacity: engineCapacity,
      status: status == CarStatusEnum.live.name ? CarStatusEnum.live : CarStatusEnum.expired,
      highestBid: highestBid,
      currency: currency,
      expiresIn: expiresIn,
    );
  }
}
