import 'package:psique_eleve/src/helpers/casters.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'users.datasource.dart';

class UsersDataSourceImpl implements UsersDataSource {
  final SupabaseClient _client;

  const UsersDataSourceImpl(this._client);

  static const pageSize = 10;

  @override
  Future<List<Map>> getUsers({required List<String> userTypes, int page = 0}) async {
    final offset = page * pageSize;
    final res = await _client.from('user').select('''
      *,
      user_role:role!inner(name),
      address(*),
      role_user:role(*)
''').in_('user_role.name', userTypes).range(0 + offset, 9 + offset).execute();

    if (res.hasError) {
      throw Exception(res.error);
    }

    return Casters.toListMap(res.data);
  }

  @override
  Future<Map> createUser(Map user, List<String> rolesId) async {
    /// Create user login

    final password = RandomPasswordGenerator().randomPassword(
      letters: true,
      numbers: true,
      passwordLength: 8,
      specialChar: false,
      uppercase: false,
    );

    final userSession = await _client.auth.signUp(user['email'], password);

    final userId = userSession.user?.id;

    if (userSession.error != null || userId == null) {
      throw Exception(userSession.error ?? 'Unknown error');
    }

    user['id'] = userId;

    /// Create user on database

    final userResponse = await _client.from('user').insert(user).execute();

    final userData = Casters.toMap(userResponse.data);

    if (userResponse.hasError) {
      throw Exception(userResponse.error ?? 'Unknown error');
    }

    /// Create user roles

    final userRoles = rolesId.map((role) => {'role_id': role, 'user_id': userId}).toList();

    final roleResponse =
        await _client.from('user_role').upsert(userRoles, ignoreDuplicates: true).execute();

    if (roleResponse.hasError) {
      throw Exception(roleResponse.error);
    }

    userData['password'] = password;

    return userData;
  }

  @override
  Future<Map> updateUser(Map user, List<String> rolesId) async {
    final id = user['id'] as String?;
    if (id == null || id.isEmpty) {
      return createUser(user, rolesId);
    }
    final res = await _client.from('user').update(user).eq('id', id).execute();
    return Casters.toMap(res.data);
  }

  @override
  Future<List<Map>> getRoles(List<String> names) async {
    final res = await _client.from('role').select('*').in_('name', names).execute();

    if (res.hasError) {
      throw Exception(res.error);
    }

    return Casters.toListMap(res.data);
  }
}
