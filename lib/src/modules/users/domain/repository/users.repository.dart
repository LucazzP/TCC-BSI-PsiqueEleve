import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/role_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/users/domain/entities/therapist_patient_relationship.entity.dart';

abstract class UsersRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers({
    required List<UserType> userTypes,
    required UserType activeUserRole,
    required String loggedUserId,
    int page = 0,
  });
  Future<Either<Failure, UserEntity>> getUser(String userId);
  Future<Either<Failure, UserEntity>> updateUser(
    UserEntity user,
    List<RoleEntity> roles,
    UserType activeUserRole,
    TherapistPatientRelationshipEntity? therapistPatientRelationship,
  );
  Future<Either<Failure, UserEntity>> createUser(
    UserEntity user,
    List<RoleEntity> roles,
    UserType activeUserRole,
  );
  Future<Either<Failure, List<RoleEntity>>> getRoles(List<UserType> userTypes);
}
