import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/extensions/dartz.dart';
import 'package:bid_for_cars/core/repositories/i_auth_repository.dart';
import 'package:bid_for_cars/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class CheckAuth implements UsecaseNoParams<User> {
  final IAuthRepository _authRepository;
  const CheckAuth(this._authRepository);

  @override
  Future<Either<Failure, User>> call() async {
    final either = await _authRepository.getCachedAuthTokens();
    if (either.isLeft()) return Left(either.asLeft);
    final authTokens = either.asRight;

    final userEither = _authRepository.userFromToken(authTokens.accessToken);
    if (userEither.isLeft()) return Left(userEither.asLeft);
    final user = userEither.asRight;

    return Right(user);
  }
}
