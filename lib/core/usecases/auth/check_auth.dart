import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/repositories/i_auth_repository.dart';
import 'package:bid_for_cars/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class CheckAuth implements UsecaseNoParams<User> {
  final IAuthRepository authRepository;

  const CheckAuth(this.authRepository);

  @override
  Future<Either<Failure, User>> call() async {
    return authRepository.getCachedAuth();
  }
}
