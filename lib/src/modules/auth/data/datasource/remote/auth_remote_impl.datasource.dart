import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_remote.datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient api;

  const AuthRemoteDataSourceImpl(this.api);

  @override
  Future<Map> getUserLogged() async {
    final user = api.auth.currentUser;
    if (user == null) return {};
    final res = await api.from('user').select().eq('id', user.id).limit(1).single().execute();
    return Map.from(res.data);
  }

  @override
  Future<Map> loginEmail({required String email, required String password}) async {
    final userResult = await api.auth.signIn(email: email, password: password);
    final error = userResult.error;
    if (error != null) {
      switch (error.message) {
        case 'Invalid login credentials':
          throw APIInvalidLoginCredentialsException();
        default:
          throw Exception(error.message);
      }
    }
    if (userResult.user == null) {
      throw APIInvalidLoginCredentialsException();
    }
    return getUserLogged();
  }

  @override
  Future<Unit> logout() async {
    final res = await api.auth.signOut();
    if(res.error != null) throw Exception(res.error?.message);
    return unit;
  }
}
