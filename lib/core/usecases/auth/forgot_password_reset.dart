import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/repositories/i_auth_repository.dart';
import 'package:bid_for_cars/core/usecases/usecase.dart';
import 'package:bid_for_cars/core/value_objects/value_objects.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class ForgotPasswordReset implements Usecase<Unit, EmailAddress> {
  final IAuthRepository repository;

  const ForgotPasswordReset(this.repository);

  @override
  Future<Either<Failure, Unit>> call(EmailAddress email) async {
    return repository.forgottenPasswordReset(email);
  }
}
