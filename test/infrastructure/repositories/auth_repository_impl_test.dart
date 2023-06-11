import 'package:bid_for_cars/core/dtos/auth/email_login_dto.dart';
import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/errors/network_failure.dart';
import 'package:bid_for_cars/core/value_objects/value_objects.dart';
import 'package:bid_for_cars/infrastructure/datasources/local_datasource/auth_local_datasource.dart';
import 'package:bid_for_cars/infrastructure/datasources/remote_datasource/auth_remote_datasource.dart';
import 'package:bid_for_cars/infrastructure/network/network_info.dart';
import 'package:bid_for_cars/infrastructure/repositories/auth_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDatasource extends Mock implements AuthRemoteDatasource {}

class MockAuthLocalDatasource extends Mock implements AuthLocalDatasource {}

class MockINetworkInfo extends Mock implements INetworkInfo {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDatasource mockAuthRemoteDatasource;
  late MockAuthLocalDatasource mockAuthLocalDatasource;

  setUp(() {
    mockAuthRemoteDatasource = MockAuthRemoteDatasource();
    mockAuthLocalDatasource = MockAuthLocalDatasource();
    repository = AuthRepositoryImpl(mockAuthRemoteDatasource, mockAuthLocalDatasource);
  });

  group('loginUserEmail', () {
    final uId = UserId("1");
    final uEmail = EmailAddress("johndoe@mail.com");
    final uPassword = Password("Pass1234");
    final uFirstName = FirstName("John");
    final uLastName = LastName("Doe");

    final loginDto = EmailLoginDto(email: uEmail, password: uPassword);
    final user = User(id: uId, firstName: uFirstName, lastName: uLastName, email: uEmail);

    test(
      'should return a remote data when the call is success',
      () async {
        // arrange
        when(() => mockAuthRemoteDatasource.loginUserEmail(any()))
            .thenAnswer((_) async => Right(user));
        // act
        final result = await repository.loginUserEmail(loginDto);
        // assert
        verify(() => mockAuthRemoteDatasource.loginUserEmail(loginDto));
        expect(result, equals(Right(user)));
      },
    );

    test(
      'should return a failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(() => mockAuthRemoteDatasource.loginUserEmail(any())).thenAnswer(
          (_) async => const Left(Failure.networkFailure(NetworkFailure.unexpectedError("error"))),
        );
        // act
        final result = await repository.loginUserEmail(loginDto);
        // assert
        verify(() => mockAuthRemoteDatasource.loginUserEmail(loginDto));
        expect(
          result,
          equals(const Left(Failure.networkFailure(NetworkFailure.unexpectedError("error")))),
        );
      },
    );
  });
}
