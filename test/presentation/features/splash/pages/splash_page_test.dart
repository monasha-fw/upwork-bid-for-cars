import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/errors/cache_failures.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/i18n/translations.g.dart';
import 'package:bid_for_cars/injection.dart';
import 'package:bid_for_cars/presentation/common/bloc/auth/auth_cubit.dart';
import 'package:bid_for_cars/presentation/extensions/failure.dart';
import 'package:bid_for_cars/presentation/features/home/pages/home_page.dart';
import 'package:bid_for_cars/presentation/routes/router.dart';
import 'package:bid_for_cars/presentation/theme/theme.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthCubit extends Mock implements AuthCubit {}

class MockUser extends Mock implements User {}

void main() {
  late MockAuthCubit mockAuthCubit;
  late MockUser mockUser;

  /// helpers
  /// cubit helpers
  void whenAuthedState() {
    whenListen(
      mockAuthCubit,
      Stream<AuthState>.fromIterable([
        const AuthProcessing(),
        Authenticated(mockUser),
      ]),
      initialState: const AuthInitial(),
    );
  }

  void whenUnauthedState() {
    whenListen(
      mockAuthCubit,
      Stream<AuthState>.fromIterable([
        const AuthProcessing(),
        Unauthenticated(const Failure.cacheFailure(CacheFailure.cacheGetFailure()).getMessage),
      ]),
      initialState: const AuthInitial(),
    );
  }

  /// usecase helpers
  void whenCheckAuth() => when(mockAuthCubit.checkAuth).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 2));
      });

  Future<void> injectableMock() async {
    if (getIt.isRegistered<AuthCubit>()) {
      /// unregister to clear the `real` object
      await getIt.unregister<AuthCubit>();

      /// then register with the `mock` object
      getIt.registerSingleton<AuthCubit>(mockAuthCubit);
    } else {
      /// if not registered before, register now with the `mock` object
      getIt.registerSingleton<AuthCubit>(mockAuthCubit);
    }
  }

  setUpAll(() async {
    configureDependencies();
    mockAuthCubit = MockAuthCubit();
    mockUser = MockUser();

    await injectableMock();

    /// arranges
    whenCheckAuth();
  });

  tearDownAll(() async {
    await getIt.reset(dispose: true);
  });

  Widget createWidgetUnderTest() {
    return BlocProvider<AuthCubit>(
      create: (context) => mockAuthCubit..checkAuth(),
      child: TranslationProvider(
        child: Builder(
          builder: (context) {
            return MaterialApp.router(
              title: 'Carsxchange',
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.light,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              routerConfig: getIt<AppRouter>().config(),
              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
            );
          },
        ),
      ),
    );
  }

  group('SplashPage', () {
    testWidgets(
      'Splash page `ProgressIndicator` is displayed initially',
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        expect(find.byType(LinearProgressIndicator), findsOneWidget);
        // // arrange
        // whenAuthedState();
        // whenCheckAuth();
        // // act
        // await tester.pumpWidget(createWidgetUnderTest());
        // print(mockAuthCubit.state);
        // await tester.pump(const Duration(milliseconds: 200));
        // print(mockAuthCubit.state);
        // // assert
        // expect(find.byType(LinearProgressIndicator), findsOneWidget);
        // // expect(find.byType(HomePage), findsOneWidget);
      },
    );

    testWidgets(
      'Navigate to `HomePage` when state is changed to `Authenticated`',
      (WidgetTester tester) async {
        // arrange
        whenAuthedState();
        whenCheckAuth();
        // act
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();

        // assert
        verify(mockAuthCubit.checkAuth);
        expect(mockAuthCubit.state, Authenticated(mockUser));
        expect(find.byType(HomePage), findsOneWidget);
      },
    );
  });
}
