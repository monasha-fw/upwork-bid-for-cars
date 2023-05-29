import 'package:freezed_annotation/freezed_annotation.dart';

part 'car.freezed.dart';

@freezed
class Car with _$Car {
  const factory Car({
    required String id,
    required String name,
    required List<String> images,
    required CarDetails details,
    required int engineCapacity,
    required String status,
    required double sellerPrice,
    required CarBids bids,
    required String currency,
    required DateTime expiresIn,
  }) = _Car;
}

@freezed
class CarDetails with _$CarDetails {
  const factory CarDetails({
    required String make,
    required String model,
    required String trim,
    required String year,
    required String mileage,
    required String registered,
    required String interior,
    required String body,
    required String specification,
    required String exteriorColor,
    required String interiorColor,
    required String keys,
    required String firstOwner,
    required String engineSize,
    required String cylinders,
    required String fuel,
    required String transmission,
    required String wheelType,
    required String carOptions,
    required String safetyBelt,
  }) = _CarDetails;
}

@freezed
class CarBids with _$CarBids {
  const factory CarBids({
    required double? highest,
    required double? minimum,
    @Default(0.0) double? userLast,
  }) = _CarBids;
}
