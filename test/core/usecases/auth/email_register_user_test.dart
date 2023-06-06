import 'package:bid_for_cars/core/dtos/auth/email_register_dto.dart';
import 'package:bid_for_cars/core/repositories/i_auth_repository.dart';
import 'package:bid_for_cars/core/usecases/auth/email_register_user.dart';
import 'package:bid_for_cars/core/value_objects/value_objects.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'email_login_user_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IAuthRepository>()])
void main() {
  late EmailRegisterUser usecase;
  late MockIAuthRepository mockIAuthRepository;

  setUp(() {
    mockIAuthRepository = MockIAuthRepository();
    usecase = EmailRegisterUser(mockIAuthRepository);
  });

  final uEmail = EmailAddress("johndoe@mail.com");
  final uPassword = Password("Pass1234");
  final uFirstName = FirstName("John");
  final uLastName = LastName("Doe");

  final registerDto = EmailRegisterDto(
    firstName: uFirstName,
    lastName: uLastName,
    email: uEmail,
    password: uPassword,
  );

  test(
    'register user using an email,password, firstName and lastName',
    () async {
      // arrange
      when(mockIAuthRepository.registerUserEmail(any)).thenAnswer((_) async => const Right(unit));
      // act
      final result = await usecase(registerDto);
      // assert
      expect(result, const Right(unit));
      verify(mockIAuthRepository.registerUserEmail(registerDto));
      verifyNoMoreInteractions(mockIAuthRepository);
    },
  );
}
