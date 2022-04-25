import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:psique_eleve/src/core/constants.dart';
import 'package:psique_eleve/src/core/exceptions.dart';
import 'package:psique_eleve/src/helpers/casters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_remote.datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient api;
  final FlutterSecureStorage secureStorage;

  const AuthRemoteDataSourceImpl(this.api, this.secureStorage);

  @override
  Future<Map> getUserLogged() async {
    final user = api.auth.currentUser;
    if (user == null) return {};
    final res = await api.from('user').select('''
    *,
    address(*),
    role_user:role(*)
  ''').eq('id', user.id).single().execute();
    return Casters.toMap(res.data);
  }

  @override
  Future<Map> loginEmail({required String email, required String password}) async {
    await Future.wait([
      secureStorage.write(key: 'email', value: email),
      secureStorage.write(key: 'password', value: password),
    ]);

    final userResult = await api.auth.signIn(
      email: email,
      password: password,
      options: AuthOptions(
        redirectTo: kIsWeb ? null : kLoginCallBackMobile,
      ),
    );
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
    if (res.error != null) throw Exception(res.error?.message);
    return unit;
  }

  @override
  Future<Unit> recoverPassword(String email) async {
    final res = await api.auth.api.resetPasswordForEmail(email);
    if (res.error != null) throw Exception(res.error?.message);
    return unit;
  }

  @override
  Future<Unit> changePassword(String password) async {
    final res = await api.auth.update(UserAttributes(password: password));
    if (res.error != null) throw Exception(res.error?.message);
    return unit;
  }
}
