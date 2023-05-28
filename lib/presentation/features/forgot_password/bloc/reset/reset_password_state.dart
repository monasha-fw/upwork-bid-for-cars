part of 'reset_password_cubit.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState({
    required EmailAddress email,
    required VerificationCode code,
    required Password password,
    required ConfirmPassword confirmPassword,
    required bool processing,
    required bool isValid,
    required bool showErrors,
    required Option<Either<String, Unit>> result,
  }) = _ResetPasswordState;

  factory ResetPasswordState.initial() => ResetPasswordState(
        email: EmailAddress(''),
        code: VerificationCode(''),
        password: Password(''),
        confirmPassword: ConfirmPassword('', ''),
        processing: false,
        isValid: false,
        showErrors: false,
        result: none(),
      );
}
