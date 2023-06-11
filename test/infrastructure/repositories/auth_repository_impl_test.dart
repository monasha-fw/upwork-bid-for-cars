import 'package:bid_for_cars/core/dtos/auth/email_login_dto.dart';
import 'package:bid_for_cars/core/entities/auth_tokens.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/errors/network_failure.dart';
import 'package:bid_for_cars/infrastructure/datasources/local_datasource/auth_local_datasource.dart';
import 'package:bid_for_cars/infrastructure/datasources/remote_datasource/auth_remote_datasource.dart';
import 'package:bid_for_cars/infrastructure/network/network_info.dart';
import 'package:bid_for_cars/infrastructure/repositories/auth_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthRemoteDatasource>(),
  MockSpec<AuthLocalDatasource>(),
  MockSpec<INetworkInfo>(),
  MockSpec<EmailLoginDto>(),
  MockSpec<AuthTokens>()
])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDatasource mockAuthRemoteDatasource;
  late MockAuthLocalDatasource mockAuthLocalDatasource;
  late MockEmailLoginDto mockDto;
  late MockAuthTokens mockAuthTokens;

  setUp(() {
    mockDto = MockEmailLoginDto();
    mockAuthTokens = MockAuthTokens();
    mockAuthRemoteDatasource = MockAuthRemoteDatasource();
    mockAuthLocalDatasource = MockAuthLocalDatasource();
    repository = AuthRepositoryImpl(mockAuthRemoteDatasource, mockAuthLocalDatasource);
  });

  group('loginUserEmail', () {
    test(
      'should return a remote data when the call is success',
      () async {
        // arrange
        when(mockAuthRemoteDatasource.loginUserEmail(mockDto))
            .thenAnswer((_) async => Right(mockAuthTokens));
        // act
        final result = await repository.loginUserEmail(mockDto);
        // assert
        verify(mockAuthRemoteDatasource.loginUserEmail(mockDto));
        expect(result, equals(Right(mockAuthTokens)));
      },
    );

    test(
      'should return a failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockAuthRemoteDatasource.loginUserEmail(mockDto)).thenAnswer(
          (_) async => const Left(Failure.networkFailure(NetworkFailure.unexpectedError("error"))),
        );
        // act
        final result = await repository.loginUserEmail(mockDto);
        // assert
        verify(mockAuthRemoteDatasource.loginUserEmail(mockDto));
        expect(
          result,
          equals(const Left(Failure.networkFailure(NetworkFailure.unexpectedError("error")))),
        );
      },
    );
  });
}
