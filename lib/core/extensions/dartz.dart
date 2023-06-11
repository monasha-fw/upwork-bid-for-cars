import 'package:dartz/dartz.dart';

extension EitherX<L, R> on Either<L, R> {
  R get asRight => (this as Right).value;
  L get asLeft => (this as Left).value;
}

extension OptionX<T> on Option<T> {
  T get asSome => fold(() => throw Exception('None!'), (value) => value);
}
