import 'package:bid_for_cars/core/dtos/auth/password_reset_dto.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/usecases/auth/reset_password.dart';
import 'package:bid_for_cars/core/value_objects/value_objects.dart';
import 'package:bid_for_cars/presentation/extensions/failure.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'reset_password_cubit.freezed.dart';
part 'reset_password_state.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPassword _resetPassword;

  ResetPasswordCubit(this._resetPassword) : super(ResetPasswordState.initial());

  void emailChanged(String str) {
    final email = EmailAddress(str);

    final isValid = email.isValid() &&
        state.code.isValid() &&
        state.password.isValid() &&
        state.confirmPassword.isValid();

    emit(state.copyWith(email: email, isValid: isValid, result: none()));
  }

  void codeChanged(String str) {
    final code = VerificationCode(str.trim());

    final isValid = code.isValid() &&
        state.email.isValid() &&
        state.password.isValid() &&
        state.confirmPassword.isValid();

    emit(state.copyWith(code: code, isValid: isValid, result: none()));
  }

  void passwordChanged(String str) {
    final password = Password(str.trim());

    final confirmPasswordStr =
        state.confirmPassword.isValid() ? state.confirmPassword.getOrCrash() : "";
    final confirmPassword = ConfirmPassword(confirmPasswordStr, str.trim());

    final isValid = password.isValid() &&
        confirmPassword.isValid() &&
        state.email.isValid() &&
        state.code.isValid();

    emit(
      state.copyWith(
        password: password,
        confirmPassword: confirmPassword,
        isValid: isValid,
        result: none(),
      ),
    );
  }

  void confirmPasswordChanged(String str) {
    final passwordStr = state.password.isValid() ? state.password.getOrCrash() : "";
    final confirmPassword = ConfirmPassword(str.trim(), passwordStr);

    final isValid = confirmPassword.isValid() &&
        state.email.isValid() &&
        state.code.isValid() &&
        state.password.isValid();

    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        isValid: isValid,
        result: none(),
      ),
    );
  }

  void resetPassword() async {
    final isEmailValid = state.email.isValid();
    final isPasswordValid = state.password.isValid();
    final isConfirmPasswordValid = state.confirmPassword.isValid();

    Either<Failure, Unit>? result;

    if (isEmailValid && isPasswordValid && isConfirmPasswordValid) {
      emit(state.copyWith(result: none(), showErrors: false, processing: true));
      final dto = PasswordResetDto(email: state.email, password: state.password, code: state.code);
      result = await _resetPassword(dto);
    }

    /// Extract message from the failure and pass it to the UI
    Either<String, Unit>? errOrResult =
        result?.fold((Failure l) => Left(l.getMessage()), (r) => Right(r));

    /// if action was a [success], wait till the other processors to finish, else stop processing UI
    emit(state.copyWith(result: optionOf(errOrResult), showErrors: true, processing: false));
  }
}
