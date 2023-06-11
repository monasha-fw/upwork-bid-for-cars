import 'package:bid_for_cars/injection.dart';
import 'package:bid_for_cars/presentation/common/app.dart';
import 'package:bid_for_cars/presentation/common/bloc/auth/auth_cubit.dart';
import 'package:bid_for_cars/presentation/routes/router.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AppRouter>(), MockSpec<AuthCubit>()])
void main() {
  late MockAppRouter mockAppRouter;
  late MockAuthCubit mockAuthCubit;

  setUpAll(() {
    mockAuthCubit = MockAuthCubit();
    mockAppRouter = MockAppRouter();

    /// injected mocks' methods
    // final router = AppRouter().config();
    // when(mockAppRouter.config()).thenReturn(router);
    when(mockAuthCubit.checkAuth()).thenAnswer((_) async {});
    when(mockAuthCubit.close()).thenAnswer((_) async {});

    /// DI
    getIt.registerSingleton<AppRouter>(mockAppRouter);
    getIt.registerSingleton<AuthCubit>(mockAuthCubit);

    whenListen(
      mockAuthCubit,
      Stream<AuthState>.fromIterable([]),
      initialState: const AuthInitial(),
    );
  });

  Future<void> createWidgetUnderTest(WidgetTester tester) async {
    runApp(const App());
    await tester.pump();
  }

  group(
    'App',
    () {
      testWidgets(
        '`MaterialApp` should be created',
        (WidgetTester tester) async {
          // act
          await createWidgetUnderTest(tester);
          // assert
          expect(find.byType(MaterialApp), findsOneWidget);
        },
      );

      testWidgets(
        '`checkAuth` should be called only once',
        (WidgetTester tester) async {
          // act
          await createWidgetUnderTest(tester);
          // assert
          verify(mockAuthCubit.checkAuth);
        },
      );

      // TODO i18n
      // TODO router
      // TODO active theme
    },
  );
}
