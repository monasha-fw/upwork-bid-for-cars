import 'package:bid_for_cars/core/entities/auth_tokens.dart';
import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/errors/cache_failures.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/infrastructure/constants/cache_keys.dart';
import 'package:bid_for_cars/infrastructure/models/auth/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

abstract class AuthLocalDatasource {
  /// Get cached authentications user tokens
  ///
  Future<Either<Failure, AuthTokens>> getCachedAuthTokens();

  /// Cache authenticated user tokens
  ///
  Future<Either<Failure, Unit>> cachedAuthTokens(AuthTokens tokens);

  /// Clear authenticated user tokens cache
  ///
  Future<Either<Failure, Unit>> clearAuthTokensCache();

  /// Retrieve [User] from the [accessToken]
  ///
  Either<Failure, User> userFromToken(String accessToken);
}

@Singleton(as: AuthLocalDatasource)
class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final FlutterSecureStorage _storage;

  const AuthLocalDatasourceImpl(this._storage);

  @override
  Future<Either<Failure, AuthTokens>> getCachedAuthTokens() async {
    try {
      var tokens = await Future.wait([
        _storage.read(key: CacheKey.accessToken.key),
        _storage.read(key: CacheKey.refreshToken.key),
      ]);

      /// if [accessToken] is null, means No previous logins
      if (tokens.first == null) {
        return const Left(Failure.cacheFailure(CacheFailure.cacheGetFailure()));
      }

      if (tokens[0] is String && (tokens[1] == null || tokens[1] is String)) {
        return Right(AuthTokens(accessToken: tokens[0]!, refreshToken: tokens[1]));
      }

      return const Left(Failure.cacheFailure(CacheFailure.cacheGetFailure()));
    } catch (e) {
      return const Left(Failure.cacheFailure(CacheFailure.cacheGetFailure()));
    }
  }

  @override
  Future<Either<Failure, Unit>> cachedAuthTokens(AuthTokens tokens) async {
    try {
      await Future.wait([
        _storage.write(key: CacheKey.accessToken.key, value: tokens.accessToken),
        _storage.write(key: CacheKey.refreshToken.key, value: tokens.refreshToken),
      ]);
      return const Right(unit);
    } catch (e) {
      return const Left(Failure.cacheFailure(CacheFailure.cacheSetFailure()));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearAuthTokensCache() async {
    try {
      await Future.wait([
        _storage.delete(key: CacheKey.accessToken.key),
        _storage.delete(key: CacheKey.refreshToken.key),
      ]);
      return const Right(unit);
    } catch (e) {
      return const Left(Failure.cacheFailure(CacheFailure.cacheClearFailure()));
    }
  }

  @override
  Either<Failure, User> userFromToken(String accessToken) {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
      final user = UserModel.fromJson({...decodedToken, "id": decodedToken['sub']}).toDomain();
      return Right(user);
    } catch (e) {
      return Left(Failure.formatException(e as FormatException));
    }
  }
}
