import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:psique_eleve/src/core/constants.dart';
import 'package:psique_eleve/src/core/exceptions.dart';
import 'package:psique_eleve/src/helpers/casters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_remote.datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _client;
  final FlutterSecureStorage secureStorage;

  const AuthRemoteDataSourceImpl(this._client, this.secureStorage);

  @override
  Future<Map> getUserLogged() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return {};
    final res = await _client.functions.invoke('get-user', body: {
      "user_id": userId,
    });

    if (res.error != null) {
      throw Exception(res.error);
    }

    final user = Casters.toMap(res.data)['data'];

    return user;
  }

  @override
  Future<Map> loginEmail({required String email, required String password}) async {
    await Future.wait([
      secureStorage.write(key: 'email', value: email),
      secureStorage.write(key: 'password', value: password),
    ]);

    final userResult = await _client.auth.signIn(
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
    final res = await _client.auth.signOut();
    if (res.error != null) throw Exception(res.error?.message);
    return unit;
  }

  @override
  Future<Unit> recoverPassword(String email) async {
    final res = await _client.auth.api.resetPasswordForEmail(email);
    if (res.error != null) throw Exception(res.error?.message);
    return unit;
  }

  @override
  Future<Unit> changePassword(String password) async {
    final res = await _client.auth.update(UserAttributes(password: password));
    if (res.error != null) throw Exception(res.error?.message);
    return unit;
  }

  @override
  Future<List<Map>> getRoles() async {
    final res = await _client.from('role').select('*').execute();
    if (res.hasError) {
      throw Exception(res.error);
    }
    return Casters.toListMap(res.data);
  }
}
