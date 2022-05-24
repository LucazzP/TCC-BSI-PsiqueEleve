import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/data/remote/api_response.dart';

extension MapExtensions on Map {
  Either<Failure, T> toEntityEither<T>(T? Function(Map map) fromMap) {
    try {
      final entity = fromMap(this);
      if (entity == null) return Left(ParseEntityFailure(T));
      return Right(entity);
    } catch (_) {
      return Left(ParseEntityFailure(T));
    }
  }

  Either<Failure, T> toEntityEitherNullable<T>(T Function(Map map) fromMap) {
    try {
      final entity = fromMap(this);
      return Right(entity);
    } catch (_) {
      return Left(ParseEntityFailure(T));
    }
  }

  Map merge(Map other) {
    other.forEach((key, value) {
      if (value != null) {
        this[key] = value;
      }
    });
    return this;
  }

  Map removeNullValues() {
    removeWhere((key, value) => value == null);
    return this;
  }

  T get<T>(String key, [T? defaultValue]) {
    return this[key] ?? defaultValue;
  }

  T? getNullable<T>(String key) {
    return this[key];
  }

  O? getTransformed<T, O>(String key, O? Function(T value) transform) {
    final value = getNullable<T>(key);
    return value?.transform<O>(transform);
  }
}

extension TransformExtNullable<T> on T? {
  O? transform<O>(O? Function(T) transform) {
    if (this == null) return null;
    if (this is String && (this as String).isEmpty) return null;
    return transform(this as T);
  }
}

extension ApiResponseExtension on ApiResponse {
  Either<Failure, T> toEntityEither<T>(T? Function(Map map) fromMap,
      [Either<Failure, T> Function(ApiResponse res)? mapError]) {
    if (isSuccess) {
      return data.toEntityEither(fromMap);
    }
    if (mapError != null) {
      return mapError(this);
    }
    return const Left(kAppFailure);
  }
}
