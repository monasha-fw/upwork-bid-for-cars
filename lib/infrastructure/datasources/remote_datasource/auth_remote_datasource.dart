import 'package:bid_for_cars/core/dtos/auth/email_login_dto.dart';
import 'package:bid_for_cars/core/dtos/auth/password_reset_dto.dart';
import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/value_objects/value_objects.dart';
import 'package:bid_for_cars/infrastructure/constants/endpoint_urls.dart';
import 'package:bid_for_cars/infrastructure/dtos/auth/email_login_model_dto.dart';
import 'package:bid_for_cars/infrastructure/dtos/auth/password_reset_model_dto.dart';
import 'package:bid_for_cars/infrastructure/errors/app_exceptions.dart';
import 'package:bid_for_cars/infrastructure/models/auth/login_response_model.dart';
import 'package:bid_for_cars/infrastructure/network/http_client.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  /// Login using email address
  ///
  /// [EmailLoginDto] containing [email] and [password]
  Future<Either<Failure, User>> loginUserEmail(EmailLoginDto dto);

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
}

@Singleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AppHttpClient client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<Either<Failure, User>> loginUserEmail(EmailLoginDto dto) async {
    try {
      final data = EmailLoginModelDto.fromDomain(dto).toJson();
      const url = EndpointUrls.loginUserEmail;

      final response = await client.post(url, data: data);

      /// get the JWT and decode it
      final loginResponse = LoginResponseModel.fromJson(response.data);

      /// get the user data from the decoded JWT
      final user = loginResponse.toUserModel().toDomain();

      return Right(user);
    } catch (e) {
      return Left(AppExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> requestPasswordReset(EmailAddress email) async {
    try {
      const url = EndpointUrls.forgottenPasswordResetRequest;

      await client.post(url, data: {"email": email.getOrCrash()});

      return const Right(unit);
    } catch (e) {
      return Left(AppExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPassword(PasswordResetDto dto) async {
    try {
      final data = PasswordResetModelDto.fromDomain(dto).toJson();
      const url = EndpointUrls.resetPassword;

      await client.post(url, data: data);

      return const Right(unit);
    } catch (e) {
      return Left(AppExceptions.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> resendVerificationCode(EmailAddress email) async {
    try {
      const url = EndpointUrls.resendVerificationCode;

      await client.post(url, data: {"email": email.getOrCrash()});

      return const Right(unit);
    } catch (e) {
      return Left(AppExceptions.exceptionToFailure(e));
    }
  }
}
