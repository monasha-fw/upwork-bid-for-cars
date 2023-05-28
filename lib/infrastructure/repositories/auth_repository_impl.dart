import 'package:bid_for_cars/core/dtos/auth/email_login_dto.dart';
import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/repositories/i_auth_repository.dart';
import 'package:bid_for_cars/infrastructure/datasources/remote_datasource/auth_remote_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> loginUserEmail(EmailLoginDto dto) {
    return remoteDataSource.loginUserEmail(dto);
  }
}
