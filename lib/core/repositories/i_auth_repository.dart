import 'package:bid_for_cars/core/dtos/auth/email_login_dto.dart';
import 'package:bid_for_cars/core/dtos/auth/email_register_dto.dart';
import 'package:bid_for_cars/core/dtos/auth/password_reset_dto.dart';
import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/value_objects/common.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  /// Login using email address
  ///
  /// [EmailLoginDto] containing [email] and [password]
  Future<Either<Failure, User>> loginUserEmail(EmailLoginDto dto);

  /// Create an account using a email address
  ///
  /// [EmailRegisterDto] containing [firstName], [lastName], [email] and [password]
  Future<Either<Failure, Unit>> registerUserEmail(EmailRegisterDto dto);

  /// Request for a password reset using [email]
  ///
  /// [email] related to the account
  Future<Either<Failure, Unit>> requestPasswordReset(EmailAddress email);

  /// Change forgotten password
  ///
  /// [email], [password] and the [verificationCode]
  Future<Either<Failure, Unit>> resetPassword(PasswordResetDto dto);

  /// Re-Sends the [verificationToken]
  ///
  /// [email] related to the account
  Future<Either<Failure, Unit>> resendVerificationCode(EmailAddress email);

  /// Check for cached authentications
  ///
  Future<Either<Failure, User>> getCachedAuth();
}
