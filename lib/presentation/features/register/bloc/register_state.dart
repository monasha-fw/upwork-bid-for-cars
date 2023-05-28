part of 'register_cubit.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    required FirstName firstName,
    required LastName lastName,
    required EmailAddress email,
    required Password password,
    required ConfirmPassword confirmPassword,
    required bool isAgree,
    required bool processing,
    required bool isValid,
    required bool showErrors,
    required Option<Either<String, Unit>> result,
  }) = _RegisterState;

  factory RegisterState.initial() => RegisterState(
        firstName: FirstName(''),
        lastName: LastName(''),
        email: EmailAddress(''),
        password: Password(''),
        confirmPassword: ConfirmPassword('', ''),
        isAgree: false,
        processing: false,
        isValid: false,
        showErrors: false,
        result: none(),
      );
}
