part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required bool processingAllCars,
    required bool processingLiveCars,
    required bool processingExpiredCars,
    required Option<Either<String, List<CarThumbnail>>> allCars,
    required Option<Either<String, List<CarThumbnail>>> liveCars,
    required Option<Either<String, List<CarThumbnail>>> expiredCars,
  }) = _HomeState;

  factory HomeState.initial() => HomeState(
        processingAllCars: false,
        processingLiveCars: false,
        processingExpiredCars: false,
        allCars: none(),
        liveCars: none(),
        expiredCars: none(),
      );
}
