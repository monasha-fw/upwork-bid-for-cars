import 'package:bid_for_cars/core/dtos/auth/email_login_dto.dart';
import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/repositories/i_auth_repository.dart';
import 'package:bid_for_cars/core/usecases/auth/email_login_user.dart';
import 'package:bid_for_cars/core/value_objects/value_objects.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'email_login_user_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IAuthRepository>()])
void main() {
  late EmailLoginUser usecase;
  late MockIAuthRepository mockIAuthRepository;

  setUp(() {
    mockIAuthRepository = MockIAuthRepository();
    usecase = EmailLoginUser(mockIAuthRepository);
  });

  final uEmail = EmailAddress("johndoe@mail.com");
  final uPassword = Password("Pass1234");
  final uFirstName = FirstName("John");
  final uLastName = LastName("Doe");

  final loginDto = EmailLoginDto(email: uEmail, password: uPassword);
  final user = User(firstName: uFirstName, lastName: uLastName, email: uEmail);

  test(
    'login user using email and password',
    () async {
      // arrange
      when(mockIAuthRepository.loginUserEmail(any)).thenAnswer((_) async => Right(user));
      // act
      final result = await usecase(loginDto);
      // assert
      expect(result, Right(user));
      verify(mockIAuthRepository.loginUserEmail(loginDto));
      verifyNoMoreInteractions(mockIAuthRepository);
    },
  );
}
