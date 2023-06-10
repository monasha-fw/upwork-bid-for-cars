import 'package:bid_for_cars/core/dtos/auth/email_register_dto.dart';
import 'package:bid_for_cars/core/repositories/i_auth_repository.dart';
import 'package:bid_for_cars/core/usecases/auth/email_register_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIAuthRepository extends Mock implements IAuthRepository {}

class MockEmailRegisterDto extends Mock implements EmailRegisterDto {}

void main() {
  late EmailRegisterUser usecase;
  late MockIAuthRepository mockIAuthRepository;

  setUp(() {
    mockIAuthRepository = MockIAuthRepository();
    usecase = EmailRegisterUser(mockIAuthRepository);

    registerFallbackValue(MockEmailRegisterDto());
  });

  final mockDto = MockEmailRegisterDto();

  test(
    'register user using an email,password, firstName and lastName',
    () async {
      // arrange
      when(() => mockIAuthRepository.registerUserEmail(any()))
          .thenAnswer((_) async => const Right(unit));
      // act
      final result = await usecase(mockDto);
      // assert
      expect(result, const Right(unit));
      verify(() => mockIAuthRepository.registerUserEmail(mockDto));
      verifyNoMoreInteractions(mockIAuthRepository);
    },
  );
}
