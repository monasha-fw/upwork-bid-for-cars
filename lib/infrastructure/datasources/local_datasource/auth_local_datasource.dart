import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/core/errors/cache_failures.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class AuthLocalDatasource {
  /// Check for cached authentications
  ///
  Future<Either<Failure, User>> getCachedAuth();
}

@Singleton(as: AuthLocalDatasource)
class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  @override
  Future<Either<Failure, User>> getCachedAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    return const Left(Failure.cacheFailure(CacheFailure.cacheGetFailure()));
  }
}
