import 'package:dartz/dartz.dart';

abstract class AuthRemoteDataSource {
  Future<Map> getUserLogged();
  Future<Map> loginEmail({required String email, required String password});
  Future<Unit> logout();
  Future<Unit> resetPassword(String email);
}
