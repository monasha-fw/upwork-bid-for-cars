import 'package:bid_for_cars/core/dtos/auth/email_login_dto.dart';
import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/usecases/auth/email_login_user.dart';
import 'package:bid_for_cars/core/value_objects/value_objects.dart';
import 'package:bid_for_cars/presentation/extensions/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final EmailLoginUser _emailLoginUser;

  LoginCubit(this._emailLoginUser) : super(LoginState.initial());

  void emailChanged(String str) {
    final email = EmailAddress(str);
    final isValid = email.isValid() && state.password.isValid();
    emit(state.copyWith(email: email, isValid: isValid, result: none()));
  }

  void passwordChanged(String str) {
    final password = Password(str.trim());
    final isValid = password.isValid() && state.email.isValid();
    emit(state.copyWith(password: password, isValid: isValid, result: none()));
  }

  void loginEmailUser() async {
    final isEmailValid = state.email.isValid();
    final isPasswordValid = state.password.isValid();

    Either<Failure, User>? result;

    if (isEmailValid && isPasswordValid) {
      emit(state.copyWith(result: none(), showErrors: false, processing: true));
      final dto = EmailLoginDto(email: state.email, password: state.password);
      result = await _emailLoginUser(dto);
    }

    /// Extract message from the failure and pass it to the UI
    Either<String, User>? errOrResult =
        result?.fold((Failure l) => Left(l.getMessage), (r) => Right(r));

    /// if action was a [success], wait till the other processors to finish, else stop processing UI
    emit(state.copyWith(result: optionOf(errOrResult), showErrors: true, processing: false));
  }
}
