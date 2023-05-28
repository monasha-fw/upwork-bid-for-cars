part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required EmailAddress email,
    required Password password,
    required bool processing,
    required bool isValid,
    required bool showErrors,
    required Option<Either<String, User>> result,
  }) = _LoginState;

  factory LoginState.initial() => LoginState(
        email: EmailAddress(''),
        password: Password(''),
        processing: false,
        isValid: false,
        showErrors: false,
        result: none(),
      );
}
