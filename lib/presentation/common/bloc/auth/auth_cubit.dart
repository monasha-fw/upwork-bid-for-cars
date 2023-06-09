import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/extensions/dartz.dart';
import 'package:bid_for_cars/core/usecases/auth/check_auth.dart';
import 'package:bid_for_cars/presentation/extensions/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final CheckAuth _checkAuth;

  AuthCubit(this._checkAuth) : super(const AuthState.initial());

  Future<void> checkAuth() async {
    print("checkAuth===");
    emit(const AuthProcessing());
    final either = await _checkAuth();
    if (either.isLeft()) return emit(Unauthenticated(either.asLeft().getMessage));
    emit(Authenticated(either.asRight()));
  }
}
