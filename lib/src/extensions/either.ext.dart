import 'package:dartz/dartz.dart';

extension EitherExtension<L, R> on Either<L, R> {
  L? get leftValue => fold((l) => l, (r) => null);
  R get rightValue => fold(
        (l) => throw Exception('You can not extract right value without check if have left before'),
        (r) => r,
      );
}
