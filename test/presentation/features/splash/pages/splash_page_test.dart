import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/injection.dart';
import 'package:bid_for_cars/presentation/common/app.dart';
import 'package:bid_for_cars/presentation/common/bloc/auth/auth_cubit.dart';
import 'package:bid_for_cars/presentation/features/home/bloc/home_cubit.dart';
import 'package:bid_for_cars/presentation/features/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../utils/when_listen.dart';
import 'splash_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthCubit>(), MockSpec<HomeCubit>(), MockSpec<User>()])
void main() {
  late MockAuthCubit mockAuthCubit;
  late MockHomeCubit mockHomeCubit;
  late MockUser mockUser;

  setUpAll(() async {
    mockAuthCubit = MockAuthCubit();
    mockHomeCubit = MockHomeCubit();
    mockUser = MockUser();

    /// injected mocks' methods
    when(mockAuthCubit.checkAuth()).thenAnswer((_) async {});
    when(mockAuthCubit.close()).thenAnswer((_) async {});
    when(mockHomeCubit.init()).thenAnswer((_) async {});
    when(mockHomeCubit.close()).thenAnswer((_) async {});

    /// DI
    getIt.registerSingleton<AuthCubit>(mockAuthCubit);
    getIt.registerSingleton<HomeCubit>(mockHomeCubit);
  });

  setUp(() {
    whenListen(
      mockAuthCubit,
      Stream<AuthState>.fromIterable([const AuthProcessing(), Authenticated(mockUser)]),
      initialState: const AuthInitial(),
    );
    whenListen(
      mockHomeCubit,
      Stream<HomeState>.fromIterable([]),
      initialState: HomeState.initial(),
    );
  });

  Widget createWidgetUnderTest() {
    return const App();
  }

  group('SplashPage', () {
    testWidgets(
      'Renders `SplashPage` with the `ProgressIndicator`',
      (WidgetTester tester) async {
        // arrange
        // act
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();
        // assert
        expect(find.byType(LinearProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'Navigate to `HomePage` when state is changed to `Authenticated`',
      (WidgetTester tester) async {
        // arrange
        // act
        await tester.pumpWidget(createWidgetUnderTest());
        // assert
        await tester.pump();
        expect(find.byType(HomePage), findsOneWidget);
      },
    );
  });
}
