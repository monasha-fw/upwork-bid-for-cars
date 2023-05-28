part of 'forgot_password_actions_cubit.dart';

@freezed
class ForgotPasswordActionsState with _$ForgotPasswordActionsState {
  const factory ForgotPasswordActionsState.initial() = ForgotPasswordActionsInitial;
  const factory ForgotPasswordActionsState.processing() = ForgotPasswordActionsProcessing;
  const factory ForgotPasswordActionsState.success() = ForgotPasswordActionsSuccess;
  const factory ForgotPasswordActionsState.failure(String error) = ForgotPasswordActionsFailure;
}
