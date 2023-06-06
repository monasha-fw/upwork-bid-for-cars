import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/injection.dart';
import 'package:bid_for_cars/presentation/common/bloc/auth/auth_cubit.dart';
import 'package:bid_for_cars/presentation/features/home/pages/home_page.dart';
import 'package:bid_for_cars/presentation/features/splash/pages/splash_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthCubit>(), MockSpec<User>()])
void main() {
  late MockAuthCubit mockAuthCubit;
  late MockUser mockUser;

  setUpAll(() {
    configureDependencies();
  });

  setUp(() async {
    mockAuthCubit = MockAuthCubit();
    mockUser = MockUser();

    if (getIt.isRegistered<AuthCubit>()) {
      /// unregister to clear the `real` object
      await getIt.unregister<AuthCubit>();

      /// then register with the `mock` object
      getIt.registerSingleton<AuthCubit>(mockAuthCubit);
    } else {
      /// if not registered before, register now with the `mock` object
      getIt.registerSingleton<AuthCubit>(mockAuthCubit);
    }
  });

  tearDownAll(() async {
    await getIt.reset(dispose: true);
  });

  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => getIt<AuthCubit>()..checkAuth()),
      ],
      child: const MaterialApp(
        title: 'Carsxchange',
        home: SplashPage(),
      ),
    );
  }

  /// helpers
  /// cubit helpers
  void whenInitState() => when(mockAuthCubit.state).thenReturn(const AuthInitial());
  void whenAuthedState() => when(mockAuthCubit.state).thenReturn(Authenticated(mockUser));
  void whenUnauthedState() => when(mockAuthCubit.state).thenReturn(const Unauthenticated("Error"));

  /// usecase helpers
  void whenCheckAuth() => when(mockAuthCubit.checkAuth()).thenAnswer((_) async {
        print("whenCheckAuth ${mockAuthCubit.state}");
        // whenAuthedState();
        print("2 whenCheckAuth ${mockAuthCubit.state}");
      });

  group('SplashPage', () {
    testWidgets(
      'Splash page should be in `AuthInitial` state when app starts',
      (WidgetTester tester) async {
        // arrange
        whenInitState();
        // act
        await tester.pumpWidget(createWidgetUnderTest());
        // assert
        expect(mockAuthCubit.state, const AuthInitial());
      },
    );

    testWidgets(
      'Splash page `ProgressIndicator` is displayed',
      (WidgetTester tester) async {
        // act
        await tester.pumpWidget(createWidgetUnderTest());
        // assert
        expect(find.byType(LinearProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'Navigate to `HomePage` when state is changed to `Authenticated`',
      (WidgetTester tester) async {
        // arrange
        whenAuthedState();
        whenCheckAuth();
        whenListen(
          mockAuthCubit,
          Stream<AuthState>.fromIterable([
            Authenticated(mockUser),
          ]),
          initialState: const AuthInitial(),
        );
        // act
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();
        // assert
        verify(mockAuthCubit.checkAuth());
        expect(mockAuthCubit.state, Authenticated(mockUser));
        expect(find.byType(HomePage), findsOneWidget);
      },
    );
  });
}
