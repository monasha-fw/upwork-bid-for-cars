import 'package:bid_for_cars/core/dtos/auth/email_register_dto.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/usecases/auth/email_register_user.dart';
import 'package:bid_for_cars/core/value_objects/value_objects.dart';
import 'package:bid_for_cars/presentation/extensions/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'register_cubit.freezed.dart';
part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final EmailRegisterUser _emailRegisterUser;

  RegisterCubit(this._emailRegisterUser) : super(RegisterState.initial());

  void emailChanged(String str) {
    final email = EmailAddress(str);

    final isValid = email.isValid() &&
        state.firstName.isValid() &&
        state.lastName.isValid() &&
        state.password.isValid() &&
        state.confirmPassword.isValid() &&
        state.isAgree;

    emit(state.copyWith(email: email, isValid: isValid, result: none()));
  }

  void firstNameChanged(String str) {
    final firstName = FirstName(str.trim());

    final isValid = firstName.isValid() &&
        state.lastName.isValid() &&
        state.email.isValid() &&
        state.password.isValid() &&
        state.confirmPassword.isValid() &&
        state.isAgree;

    emit(state.copyWith(firstName: firstName, isValid: isValid, result: none()));
  }

  void lastNameChanged(String str) {
    final lastName = LastName(str.trim());

    final isValid = lastName.isValid() &&
        state.firstName.isValid() &&
        state.email.isValid() &&
        state.password.isValid() &&
        state.confirmPassword.isValid() &&
        state.isAgree;

    emit(state.copyWith(lastName: lastName, isValid: isValid, result: none()));
  }

  void passwordChanged(String str) {
    final password = Password(str.trim());

    final confirmPasswordStr =
        state.confirmPassword.isValid() ? state.confirmPassword.getOrCrash() : "";
    final confirmPassword = ConfirmPassword(confirmPasswordStr, str.trim());

    final isValid = password.isValid() &&
        confirmPassword.isValid() &&
        state.firstName.isValid() &&
        state.lastName.isValid() &&
        state.email.isValid() &&
        state.isAgree;

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
        state.firstName.isValid() &&
        state.lastName.isValid() &&
        state.email.isValid() &&
        state.password.isValid() &&
        state.isAgree;

    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        isValid: isValid,
        result: none(),
      ),
    );
  }

  void agreementChanged(bool? isAgree) {
    if (isAgree == null) return;

    final isValid = state.email.isValid() &&
        state.firstName.isValid() &&
        state.lastName.isValid() &&
        state.password.isValid() &&
        state.confirmPassword.isValid() &&
        isAgree;

    emit(state.copyWith(isAgree: isAgree, isValid: isValid, result: none()));
  }

  void registerUserEmail() async {
    final isEmailValid = state.email.isValid();
    final isPasswordValid = state.password.isValid();
    final isConfirmPasswordValid = state.confirmPassword.isValid();

    Either<Failure, Unit>? result;

    if (isEmailValid && isPasswordValid && isConfirmPasswordValid) {
      emit(state.copyWith(result: none(), showErrors: false, processing: true));
      final dto = EmailRegisterDto(
        firstName: state.firstName,
        lastName: state.lastName,
        email: state.email,
        password: state.password,
      );
      result = await _emailRegisterUser(dto);
    }

    /// Extract message from the failure and pass it to the UI
    Either<String, Unit>? errOrResult =
        result?.fold((Failure l) => Left(l.getMessage()), (r) => Right(r));

    /// if action was a [success], wait till the other processors to finish, else stop processing UI
    emit(state.copyWith(result: optionOf(errOrResult), showErrors: true, processing: false));
  }
}
