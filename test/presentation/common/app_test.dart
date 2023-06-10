import 'package:bid_for_cars/injection.dart';
import 'package:bid_for_cars/presentation/common/app.dart';
import 'package:bid_for_cars/presentation/common/bloc/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthCubit extends Mock implements AuthCubit {}

void main() {
  late MockAuthCubit mockAuthCubit;

  setUpAll(() {
    configureDependencies();
  });

  setUp(() async {
    mockAuthCubit = MockAuthCubit();

    if (getIt.isRegistered<AuthCubit>()) {
      /// unregister to clear the `real` object
      await getIt.unregister<AuthCubit>();

      /// then register with the `mock` object
      getIt.registerSingleton<AuthCubit>(mockAuthCubit);
    } else {
      /// if not registered before, register now with the `mock` object
      getIt.registerSingleton<AuthCubit>(mockAuthCubit);
    }
    when(mockAuthCubit.checkAuth).thenAnswer((_) async => {});
  });

  tearDownAll(() async {
    await getIt.reset(dispose: true);
  });

  Widget createWidgetUnderTest() {
    return const App();
  }

  group(
    'App',
    () {
      testWidgets(
        '`MaterialApp` should be created',
        (WidgetTester tester) async {
          // act
          await tester.pumpWidget(createWidgetUnderTest());

          /// Since the UI has a `LinearProgressIndicator`, use `pump` without the `settle` to build frames.
          await tester.pump();
          // assert
          expect(find.byType(MaterialApp), findsOneWidget);
        },
      );

      testWidgets(
        '`checkAuth` should be called only once',
        (WidgetTester tester) async {
          // act
          await tester.pumpWidget(createWidgetUnderTest());

          /// Since the UI has a `LinearProgressIndicator`, use `pump` without the `settle` to build frames.
          await tester.pump();
          // assert
          verify(mockAuthCubit.checkAuth);
        },
      );
    },
  );
}
