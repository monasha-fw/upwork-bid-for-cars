import 'package:bid_for_cars/core/dtos/auth/email_login_dto.dart';
import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  /// Login using email address
  ///
  /// [EmailLoginDto] containing [email] and [password]
  Future<Either<Failure, User>> loginUserEmail(EmailLoginDto dto);
}
