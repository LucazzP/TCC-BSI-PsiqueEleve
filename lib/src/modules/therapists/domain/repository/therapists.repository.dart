import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';

abstract class TherapistsRepository {
  Future<Either<Failure, List<UserEntity>>> getTherapists({int page = 0});
  Future<Either<Failure, UserEntity>> updateTherapist(UserEntity therapist);
  Future<Either<Failure, UserEntity>> createTherapist(UserEntity therapist);
}
