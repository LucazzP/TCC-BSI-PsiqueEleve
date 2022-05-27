import 'package:dartz/dartz.dart';

abstract class AuthRemoteDataSource {
  Future<Map> getUserLogged();
  Future<Map> loginEmail({required String email, required String password});
  Future<Unit> logout();
  Future<Unit> recoverPassword(String email);
  Future<Unit> changePassword(String password);
  Future<List<Map>> getRoles();
}
