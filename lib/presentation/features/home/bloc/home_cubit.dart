import 'package:bid_for_cars/core/dtos/car/get_cars_dto.dart';
import 'package:bid_for_cars/core/entities/car_thumbnail.dart';
import 'package:bid_for_cars/core/enums/car.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/extensions/dartz.dart';
import 'package:bid_for_cars/core/options/get_pagination.dart';
import 'package:bid_for_cars/core/usecases/cars/get_cars.dart';
import 'package:bid_for_cars/presentation/extensions/failure.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetCars _getCars;

  HomeCubit(this._getCars) : super(HomeState.initial());

  void init() async {
    /// get cars for all 3 categories
    getAllCars();
    getLiveCars();
    getExpiredCars();
  }

  void getAllCars() async {
    emit(state.copyWith(processingAllCars: true));
    const dto = GetCarsDto(pagination: GetPagination());
    final result = await _getCars(dto);

    /// Extract message from the failure and pass it to the UI
    Either<String, List<CarThumbnail>> errOrResult = result.fold(
      (Failure l) => Left(l.getMessage()),
      (r) {
        final live = r.where((c) => c.status == CarStatusEnum.live).toList()
          ..sort((a, b) => (a.expiresIn).compareTo(b.expiresIn));
        final expired = r.where((c) => c.status == CarStatusEnum.expired).toList()
          ..sort((a, b) => (b.expiresIn).compareTo(a.expiresIn));
        return Right(live..addAll(expired));
      },
    );

    /// if action was a [success], wait till the other processors to finish, else stop processing UI
    emit(state.copyWith(allCars: optionOf(errOrResult), processingAllCars: false));
  }

  void getLiveCars() async {
    emit(state.copyWith(processingLiveCars: true));
    const dto = GetCarsDto(status: CarStatusEnum.live, pagination: GetPagination());
    final result = await _getCars(dto);

    /// Extract message from the failure and pass it to the UI
    Either<String, List<CarThumbnail>> errOrResult = result.fold(
      (Failure l) => Left(l.getMessage()),
      (r) => Right(r..sort((a, b) => (a.expiresIn).compareTo(b.expiresIn))),
    );

    /// if action was a [success], wait till the other processors to finish, else stop processing UI
    emit(state.copyWith(liveCars: optionOf(errOrResult), processingLiveCars: false));
  }

  void getExpiredCars() async {
    emit(state.copyWith(processingExpiredCars: true));
    const dto = GetCarsDto(status: CarStatusEnum.expired, pagination: GetPagination());
    final result = await _getCars(dto);

    /// Extract message from the failure and pass it to the UI
    Either<String, List<CarThumbnail>> errOrResult = result.fold(
      (Failure l) => Left(l.getMessage()),
      (r) => Right(r..sort((a, b) => (b.expiresIn).compareTo(a.expiresIn))),
    );

    /// if action was a [success], wait till the other processors to finish, else stop processing UI
    emit(state.copyWith(expiredCars: optionOf(errOrResult), processingExpiredCars: false));
  }

  void updateAsExpired(String id) {
    final car = state.allCars.asSome().asRight().firstWhereOrNull((c) => c.id == id);
    if (car != null) {
      final updatedCar = car.copyWith(status: CarStatusEnum.expired);

      final live = state.liveCars.asSome().asRight()
        ..remove(car)
        ..sort((a, b) => (a.expiresIn).compareTo(b.expiresIn));
      final expired = state.expiredCars.asSome().asRight()
        ..add(updatedCar)
        ..sort((a, b) => (b.expiresIn).compareTo(a.expiresIn));

      /// all cars
      final all = state.allCars.asSome().asRight()
        ..remove(car)
        ..add(updatedCar);

      final allLive = all.where((c) => c.status == CarStatusEnum.live).toList()
        ..sort((a, b) => (a.expiresIn).compareTo(b.expiresIn));
      final allExpired = all.where((c) => c.status == CarStatusEnum.expired).toList()
        ..sort((a, b) => (b.expiresIn).compareTo(a.expiresIn));

      emit(state.copyWith(
        allCars: optionOf(Right(List.of(allLive..addAll(allExpired)))),
        liveCars: optionOf(Right(List.of(live))),
        expiredCars: optionOf(Right(List.of(expired))),
      ));
    }
  }
}
