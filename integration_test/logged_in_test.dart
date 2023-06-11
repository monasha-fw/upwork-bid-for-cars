import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/infrastructure/mocks/mocks.dart';
import 'package:bid_for_cars/infrastructure/models/car/car_thumbnail_model.dart';
import 'package:bid_for_cars/injection.dart';
import 'package:bid_for_cars/presentation/common/app.dart';
import 'package:bid_for_cars/presentation/common/bloc/auth/auth_cubit.dart';
import 'package:bid_for_cars/presentation/features/home/bloc/home_cubit.dart';
import 'package:bid_for_cars/presentation/features/home/pages/home_page.dart';
import 'package:bid_for_cars/presentation/routes/router.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppRouter extends Mock implements AppRouter {}

class MockAuthCubit extends Mock implements AuthCubit {}

class MockHomeCubit extends Mock implements HomeCubit {}

class MockUser extends Mock implements User {}

void main() {
  late MockAppRouter mockAppRouter;
  late MockAuthCubit mockAuthCubit;
  late MockHomeCubit mockHomeCubit;
  late MockUser mockUser;

  setUpAll(() async {
    mockAuthCubit = MockAuthCubit();
    mockAppRouter = MockAppRouter();
    mockHomeCubit = MockHomeCubit();
    mockUser = MockUser();

    /// injected mocks' methods
    when(mockAppRouter.config).thenReturn(AppRouter().config());
    when(mockAuthCubit.checkAuth).thenAnswer((_) async {});
    when(mockAuthCubit.close).thenAnswer((_) async {});
    when(mockHomeCubit.init).thenAnswer((_) async {});
    when(mockHomeCubit.close).thenAnswer((_) async {});

    /// DI
    getIt.registerSingleton<AppRouter>(mockAppRouter);
    getIt.registerSingleton<AuthCubit>(mockAuthCubit);
    getIt.registerSingleton<HomeCubit>(mockHomeCubit);
  });

  Widget createWidgetUnderTest() {
    return const App();
  }

  testWidgets(
    """
    should redirect to `HomePage` when the device has a previously cached logged in user
    and when on `HomePage`, `init` should be triggered and data for all car types should load
    """,
    (WidgetTester tester) async {
      // arrange

      final allCars =
          MockingData.allCarsData.map((e) => CarThumbnailModel.fromJson(e).toDomain()).toList();
      final liveCars =
          MockingData.liveCarsData.map((e) => CarThumbnailModel.fromJson(e).toDomain()).toList();
      final expiredCars =
          MockingData.expiredCarsData.map((e) => CarThumbnailModel.fromJson(e).toDomain()).toList();
      whenListen(
        mockAuthCubit,
        Stream<AuthState>.fromIterable([const AuthProcessing(), Authenticated(mockUser)]),
        initialState: const AuthInitial(),
      );
      whenListen(
        mockHomeCubit,
        Stream<HomeState>.fromIterable([
          HomeState(
            processingAllCars: true,
            processingLiveCars: true,
            processingExpiredCars: true,
            allCars: none(),
            liveCars: none(),
            expiredCars: none(),
          ),
          HomeState(
            processingAllCars: true,
            processingLiveCars: true,
            processingExpiredCars: true,
            allCars: none(),
            liveCars: none(),
            expiredCars: none(),
          ),
          HomeState(
            processingAllCars: false,
            processingLiveCars: false,
            processingExpiredCars: false,
            allCars: optionOf(Right(allCars)),
            liveCars: optionOf(Right(liveCars)),
            expiredCars: optionOf(Right(expiredCars)),
          ),
        ]),
        initialState: HomeState.initial(),
      );

      // act
      await tester.pumpWidget(createWidgetUnderTest());
      // assert
      await tester.pump();
      expect(find.byType(LinearProgressIndicator), findsOneWidget);

      /// navigate to `HomePage` on successful authentication
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
      await Future.delayed(const Duration(seconds: 1));
    },
  );
}
