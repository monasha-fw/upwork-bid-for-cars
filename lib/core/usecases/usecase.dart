import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UsecaseNoParams<Type> {
  Future<Either<Failure, Type>> call();
}

abstract class UsecaseSync<Type, Params> {
  Either<Failure, Type> call(Params params);
}

abstract class UsecaseStream<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}
