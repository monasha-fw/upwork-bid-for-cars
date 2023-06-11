import 'package:bid_for_cars/core/dtos/auth/email_register_dto.dart';
import 'package:bid_for_cars/core/repositories/i_auth_repository.dart';
import 'package:bid_for_cars/core/usecases/auth/email_register_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'email_register_user_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IAuthRepository>(), MockSpec<EmailRegisterDto>()])
void main() {
  late EmailRegisterUser usecase;
  late MockIAuthRepository mockIAuthRepository;
  late MockEmailRegisterDto mockDto;

  setUp(() {
    mockDto = MockEmailRegisterDto();
    mockIAuthRepository = MockIAuthRepository();
    usecase = EmailRegisterUser(mockIAuthRepository);
  });

  test(
    'register user using an email,password, firstName and lastName',
    () async {
      // arrange
      when(mockIAuthRepository.registerUserEmail(mockDto))
          .thenAnswer((_) async => const Right(unit));
      // act
      final result = await usecase(mockDto);
      // assert
      expect(result, const Right(unit));
      verify(mockIAuthRepository.registerUserEmail(mockDto));
      verifyNoMoreInteractions(mockIAuthRepository);
    },
  );
}
