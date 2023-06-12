import 'package:bid_for_cars/injection.dart';
import 'package:bid_for_cars/presentation/common/app.dart';
import 'package:bid_for_cars/presentation/common/bloc/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthCubit>()])
void main() {
  late MockAuthCubit mockAuthCubit;

  setUpAll(() {
    mockAuthCubit = MockAuthCubit();

    /// injected mocks' methods
    // when(mockAuthCubit.state).thenReturn(const AuthInitial());
    when(mockAuthCubit.checkAuth()).thenAnswer((_) async {});
    when(mockAuthCubit.close()).thenAnswer((_) async {});

    /// DI
    getIt.registerSingleton<AuthCubit>(mockAuthCubit);
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
          verify(mockAuthCubit.checkAuth());
        },
      );

      // TODO i18n
      // TODO router
      // TODO active theme
    },
  );
}
