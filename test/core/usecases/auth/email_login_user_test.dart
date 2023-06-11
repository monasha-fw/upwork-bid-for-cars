import 'package:bid_for_cars/core/dtos/auth/email_login_dto.dart';
import 'package:bid_for_cars/core/entities/auth_tokens.dart';
import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/repositories/i_auth_repository.dart';
import 'package:bid_for_cars/core/usecases/auth/email_login_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'email_login_user_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<IAuthRepository>(),
  MockSpec<EmailLoginDto>(),
  MockSpec<AuthTokens>(),
  MockSpec<User>()
])
void main() {
  late EmailLoginUser usecase;
  late MockIAuthRepository mockIAuthRepository;
  late MockEmailLoginDto mockDto;
  late MockAuthTokens mockAuthTokens;
  late MockUser mockUser;

  setUp(() {
    mockDto = MockEmailLoginDto();
    mockAuthTokens = MockAuthTokens();
    mockIAuthRepository = MockIAuthRepository();
    mockUser = MockUser();
    usecase = EmailLoginUser(mockIAuthRepository);
  });

  test(
    'Should return a `User` when logged in using a valid email and password',
    () async {
      // arrange
      when(mockAuthTokens.accessToken).thenReturn("accessToken");
      when(mockIAuthRepository.userFromToken(any)).thenReturn(Right(mockUser));
      when(mockIAuthRepository.loginUserEmail(mockDto))
          .thenAnswer((_) async => Right(mockAuthTokens));
      // act
      final result = await usecase(mockDto);
      // assert
      verify(mockIAuthRepository.loginUserEmail(mockDto));
      verify(mockIAuthRepository.userFromToken(mockAuthTokens.accessToken));
      verifyNoMoreInteractions(mockIAuthRepository);
      expect(result, Right(mockUser));
    },
  );
}
