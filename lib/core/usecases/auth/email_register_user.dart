import 'package:bid_for_cars/core/dtos/auth/email_register_dto.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/repositories/i_auth_repository.dart';
import 'package:bid_for_cars/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class EmailRegisterUser implements Usecase<Unit, EmailRegisterDto> {
  final IAuthRepository repository;

  const EmailRegisterUser(this.repository);

  @override
  Future<Either<Failure, Unit>> call(EmailRegisterDto dto) async {
    return repository.registerUserEmail(dto);
  }
}
