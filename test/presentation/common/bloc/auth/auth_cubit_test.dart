import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/errors/cache_failures.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/usecases/auth/check_auth.dart';
import 'package:bid_for_cars/presentation/common/bloc/auth/auth_cubit.dart';
import 'package:bid_for_cars/presentation/extensions/failure.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCheckAuth extends Mock implements CheckAuth {}

class MockUser extends Mock implements User {}

void main() {
  late AuthCubit authCubit;
  late MockCheckAuth mockCheckAuth;
  late MockUser mockUser;

  setUp(() {
    mockCheckAuth = MockCheckAuth();
    mockUser = MockUser();
    authCubit = AuthCubit(mockCheckAuth);
  });

  /// helpers
  whenHasCache() => when(mockCheckAuth.call).thenAnswer((_) async => Right(mockUser));
  whenNoCache() => when(mockCheckAuth.call)
      .thenAnswer((_) async => const Left(Failure.cacheFailure(CacheFailure.cacheGetFailure())));

  group('AuthCubit', () {
    test(
      'initial should return `AuthInitial`',
      () async => expect(authCubit.state, const AuthInitial()),
    );

    group('CheckAuth', () {
      blocTest<AuthCubit, AuthState>(
        'calls `CheckAuth` usecase only once',
        build: () => authCubit,
        setUp: whenHasCache,
        act: (cubit) => cubit.checkAuth(),
        verify: (_) => verify(mockCheckAuth.call).called(1),
      );

      blocTest(
        'should change state to `Authenticated` when previous cache exists',
        build: () => authCubit,
        setUp: whenHasCache,
        act: (cubit) => cubit.checkAuth(),
        expect: () => <AuthState>[
          const AuthProcessing(),
          Authenticated(mockUser),
        ],
      );

      blocTest(
        "should change state to `Unauthenticated` when there's no valid previous caches in the device",
        build: () => authCubit,
        setUp: whenNoCache,
        act: (cubit) => cubit.checkAuth(),
        expect: () => <AuthState>[
          const AuthProcessing(),
          Unauthenticated(const Failure.cacheFailure(CacheFailure.cacheGetFailure()).getMessage),
        ],
      );
    });
  });
}
