import 'package:bid_for_cars/core/dtos/auth/email_login_dto.dart';
import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/repositories/i_auth_repository.dart';
import 'package:bid_for_cars/core/usecases/auth/email_login_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIAuthRepository extends Mock implements IAuthRepository {}

class MockEmailLoginDto extends Mock implements EmailLoginDto {}

class MockUser extends Mock implements User {}

void main() {
  late EmailLoginUser usecase;
  late MockIAuthRepository mockIAuthRepository;

  setUpAll(() {
    mockIAuthRepository = MockIAuthRepository();
    usecase = EmailLoginUser(mockIAuthRepository);

    registerFallbackValue(MockEmailLoginDto());
  });

  final mockDto = MockEmailLoginDto();
  final mockUser = MockUser();

  test(
    'login user using email and password',
    () async {
      // arrange
      when(() => mockIAuthRepository.loginUserEmail(captureAny()))
          .thenAnswer((_) async => Right(mockUser));
      // act
      final result = await usecase(mockDto);
      // assert
      expect(result, Right(mockUser));
      verify(() => mockIAuthRepository.loginUserEmail(mockDto));
      verifyNoMoreInteractions(mockIAuthRepository);
    },
  );
}
