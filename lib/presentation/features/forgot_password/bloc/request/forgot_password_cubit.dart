import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/usecases/auth/request_password_reset.dart';
import 'package:bid_for_cars/core/value_objects/value_objects.dart';
import 'package:bid_for_cars/presentation/extensions/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'forgot_password_cubit.freezed.dart';
part 'forgot_password_state.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final RequestPasswordReset _requestPasswordReset;

  ForgotPasswordCubit(this._requestPasswordReset) : super(ForgotPasswordState.initial());

  void emailChanged(String str) {
    final email = EmailAddress(str);
    final isValid = email.isValid();
    emit(state.copyWith(email: email, isValid: isValid, result: none()));
  }

  void requestPasswordReset() async {
    final isEmailValid = state.email.isValid();

    Either<Failure, Unit>? result;

    if (isEmailValid) {
      emit(state.copyWith(result: none(), showErrors: false, processing: true));
      result = await _requestPasswordReset(state.email);
    }

    /// Extract message from the failure and pass it to the UI
    Either<String, Unit>? errOrResult =
        result?.fold((Failure l) => Left(l.getMessage()), (r) => Right(r));

    /// if action was a [success], wait till the other processors to finish, else stop processing UI
    emit(state.copyWith(result: optionOf(errOrResult), showErrors: true, processing: false));
  }
}
