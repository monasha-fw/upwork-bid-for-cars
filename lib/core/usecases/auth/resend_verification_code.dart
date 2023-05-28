import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/repositories/i_auth_repository.dart';
import 'package:bid_for_cars/core/usecases/usecase.dart';
import 'package:bid_for_cars/core/value_objects/common.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class ResendVerificationCode implements Usecase<Unit, EmailAddress> {
  final IAuthRepository repository;

  const ResendVerificationCode(this.repository);

  @override
  Future<Either<Failure, Unit>> call(EmailAddress email) async {
    return repository.resendVerificationCode(email);
  }
}
