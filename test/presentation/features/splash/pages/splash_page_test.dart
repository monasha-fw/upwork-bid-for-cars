import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/injection.dart';
import 'package:bid_for_cars/presentation/common/app.dart';
import 'package:bid_for_cars/presentation/common/bloc/auth/auth_cubit.dart';
import 'package:bid_for_cars/presentation/features/home/pages/home_page.dart';
import 'package:bid_for_cars/presentation/routes/router.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthCubit extends Mock implements AuthCubit {}

class MockAppRouter extends Mock implements AppRouter {}

class MockUser extends Mock implements User {}

void main() {
  late MockAuthCubit mockAuthCubit;
  late MockAppRouter mockAppRouter;
  late MockUser mockUser;

  setUpAll(() async {
    mockAuthCubit = MockAuthCubit();
    mockAppRouter = MockAppRouter();
    mockUser = MockUser();

    /// injected mocks' methods
    when(mockAuthCubit.checkAuth).thenAnswer((_) async {});
    when(mockAuthCubit.close).thenAnswer((_) async {});
    when(mockAppRouter.config).thenReturn(AppRouter().config());

    /// DI
    getIt.registerSingleton<AuthCubit>(mockAuthCubit);
    getIt.registerSingleton<AppRouter>(mockAppRouter);
  });

  Widget createWidgetUnderTest() {
    return const App();
  }

  group('SplashPage', () {
    testWidgets(
      'Renders `SplashPage` with the `ProgressIndicator`',
      (WidgetTester tester) async {
        // arrange
        whenListen(
          mockAuthCubit,
          Stream<AuthState>.fromIterable([const AuthProcessing(), Authenticated(mockUser)]),
          initialState: const AuthInitial(),
        );
        // act
        await tester.pumpWidget(createWidgetUnderTest());
        // assert
        await tester.pump();
        expect(find.byType(LinearProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'Navigate to `HomePage` when state is changed to `Authenticated`',
      (WidgetTester tester) async {
        // arrange
        whenListen(
          mockAuthCubit,
          Stream<AuthState>.fromIterable([const AuthProcessing(), Authenticated(mockUser)]),
          initialState: const AuthInitial(),
        );

        // act
        await tester.pumpWidget(createWidgetUnderTest());
        // assert
        await tester.pump();
        expect(find.byType(LinearProgressIndicator), findsOneWidget);

        /// navigate to `HomePage` on successful authentication
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsOneWidget);
      },
    );
  });
}
