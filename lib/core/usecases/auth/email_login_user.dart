import 'package:bid_for_cars/core/dtos/auth/email_login_dto.dart';
import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/extensions/dartz.dart';
import 'package:bid_for_cars/core/repositories/i_auth_repository.dart';
import 'package:bid_for_cars/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class EmailLoginUser implements Usecase<User, EmailLoginDto> {
  final IAuthRepository _repository;

  const EmailLoginUser(this._repository);

  @override
  Future<Either<Failure, User>> call(EmailLoginDto dto) async {
    /// get [authTokens] from the login
    final either = await _repository.loginUserEmail(dto);
    if (either.isLeft()) return Left(either.asLeft);
    final authTokens = either.asRight;

    /// extract user from the [accessToken]
    final userEither = _repository.userFromToken(authTokens.accessToken);
    if (userEither.isLeft()) return Left(userEither.asLeft);
    final user = userEither.asRight;

    return Right(user);
  }
}
