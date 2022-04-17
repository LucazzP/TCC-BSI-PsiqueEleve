import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';

abstract class UsersRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers({int page = 0});
  Future<Either<Failure, UserEntity>> updateUser(UserEntity therapist);
  Future<Either<Failure, UserEntity>> createUser(UserEntity therapist);
}
