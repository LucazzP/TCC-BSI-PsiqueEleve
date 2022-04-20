import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity?>> getUserLogged();
  Future<Either<Failure, UserEntity>> loginEmail({required String email, required String password});
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, Unit>> resetLocalUser();
  Future<Either<Failure, Unit>> recoverPassword(String email);
  Future<Either<Failure, Unit>> changePassword(String password);
}
