part of 'forgot_password_cubit.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    required EmailAddress email,
    required bool processing,
    required bool isValid,
    required bool showErrors,
    required Option<Either<String, Unit>> result,
  }) = _ForgotPasswordState;

  factory ForgotPasswordState.initial() => ForgotPasswordState(
        email: EmailAddress(''),
        processing: false,
        isValid: false,
        showErrors: false,
        result: none(),
      );
}
