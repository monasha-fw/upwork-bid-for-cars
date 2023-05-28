import 'package:bid_for_cars/core/dtos/auth/email_login_dto.dart';
import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/value_objects/common.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  /// Login using email address
  ///
  /// [EmailLoginDto] containing [email] and [password]
  Future<Either<Failure, User>> loginUserEmail(EmailLoginDto dto);

  /// Request for a password reset using [email]
  ///
  /// [email] related to the account
  Future<Either<Failure, Unit>> forgottenPasswordReset(EmailAddress email);
}
