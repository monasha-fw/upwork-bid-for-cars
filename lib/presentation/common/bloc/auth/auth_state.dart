part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.processing() = AuthProcessing;
  const factory AuthState.authenticated(User user) = Authenticated;
  const factory AuthState.unauthenticated(String error) = Unauthenticated;
}
