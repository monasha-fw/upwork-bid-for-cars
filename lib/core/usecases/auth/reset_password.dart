import 'package:bid_for_cars/core/dtos/auth/password_reset_dto.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/repositories/i_auth_repository.dart';
import 'package:bid_for_cars/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class ResetPassword implements Usecase<Unit, PasswordResetDto> {
  final IAuthRepository repository;

  const ResetPassword(this.repository);

  @override
  Future<Either<Failure, Unit>> call(PasswordResetDto dto) async {
    return repository.resetPassword(dto);
  }
}
