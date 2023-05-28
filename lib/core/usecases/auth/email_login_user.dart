import 'package:bid_for_cars/core/dtos/auth/email_login_dto.dart';
import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/repositories/i_auth_repository.dart';
import 'package:bid_for_cars/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class EmailLoginUser implements Usecase<User, EmailLoginDto> {
  final IAuthRepository repository;

  EmailLoginUser(this.repository);

  @override
  Future<Either<Failure, User>> call(EmailLoginDto dto) async {
    return await repository.loginUserEmail(dto);
  }
}
