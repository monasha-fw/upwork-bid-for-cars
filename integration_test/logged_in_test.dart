import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/injection.dart';
import 'package:bid_for_cars/presentation/common/app.dart';
import 'package:bid_for_cars/presentation/common/bloc/auth/auth_cubit.dart';
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
  late MockUser mockUser;

  /// Common arranges
  // states
  whenState() {
    whenListen(
      mockAuthCubit,
      Stream<AuthState>.fromIterable([
        const AuthProcessing(),
        Authenticated(mockUser),
      ]),
      initialState: const AuthInitial(),
    );
  }

  // function calls
  whenHasAuth() {
    when(mockAuthCubit.checkAuth).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));
    });
  }

  setUpAll(() async {
    configureDependencies();
    mockAuthCubit = MockAuthCubit();
    mockUser = MockUser();

    if (getIt.isRegistered<AuthCubit>()) {
      /// unregister to clear the `real` object, then register with the `mock` object
      await getIt.unregister<AuthCubit>();
      getIt.registerSingleton<AuthCubit>(mockAuthCubit);
    } else {
      /// if not registered before, register now with the `mock` object
      getIt.registerSingleton<AuthCubit>(mockAuthCubit);
    }

    // arranges
    whenState();
    when(() => mockAuthCubit.checkAuth()).thenAnswer((_) async {});
  });

  // tearDownAll(() async {
  //   await getIt.reset(dispose: true);
  // });

  Widget createWidgetUnderTest() {
    return const App();
  }

  testWidgets(
    "should redirect to `HomePage` when the device has a previously cached logged in user",
    (WidgetTester tester) async {
      // act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      print("Pumped");
      // assert
      expectLater(find.byType(LinearProgressIndicator), findsOneWidget);
      await tester.pump();
    },
  );
}
