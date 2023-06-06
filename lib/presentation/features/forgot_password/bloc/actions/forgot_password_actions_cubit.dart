import 'package:bid_for_cars/core/extensions/dartz.dart';
import 'package:bid_for_cars/core/usecases/auth/resend_verification_code.dart';
import 'package:bid_for_cars/core/value_objects/value_objects.dart';
import 'package:bid_for_cars/presentation/extensions/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'forgot_password_actions_cubit.freezed.dart';
part 'forgot_password_actions_state.dart';

@injectable
class ForgotPasswordActionsCubit extends Cubit<ForgotPasswordActionsState> {
  final ResendVerificationCode _resendVerificationCode;

  ForgotPasswordActionsCubit(this._resendVerificationCode)
      : super(const ForgotPasswordActionsState.initial());

  void resendVerificationCode(EmailAddress email) async {
    emit(const ForgotPasswordActionsProcessing());

    final either = await _resendVerificationCode(email);

    if (either.isLeft()) return emit(ForgotPasswordActionsFailure(either.asLeft().getMessage));
    return emit(const ForgotPasswordActionsSuccess());
  }
}
