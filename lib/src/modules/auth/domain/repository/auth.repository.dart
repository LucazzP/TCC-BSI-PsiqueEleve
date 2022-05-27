import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/role_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity?>> getUserLogged();
  Future<void> updateLocalUserWithRemote();
  Future<Either<Failure, UserEntity>> loginEmail({required String email, required String password});
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, Unit>> resetLocalUser();
  Future<Either<Failure, Unit>> recoverPassword(String email);
  Future<Either<Failure, Unit>> changePassword(String password);
  Future<Either<Failure, UserType>> getSelectedUserRole();
  Future<Either<Failure, List<RoleEntity>>> getRoles();
  Future<Either<Failure, Unit>> setSelectedUserRole(UserType userType);
}
