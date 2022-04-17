import 'package:psique_eleve/src/helpers/casters.dart';
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
      user_role:role!inner(name)
''').in_('user_role.name', userTypes).range(0 + offset, 9 + offset).execute();

    if (res.hasError) {
      throw Exception(res.error);
    }

    return Casters.toListMap(res.data);
  }

  @override
  Future<Map> createUser(Map user, List<String> rolesId) async {
    final userResponse = await _client.from('user').insert(user).execute();

    final userData = Casters.toMap(userResponse.data);

    if (userResponse.hasError || userData['id'] == null) {
      throw Exception(userResponse.error ?? 'Unknown error');
    }

    final userRoles = rolesId.map((role) => {'role_id': role, 'user_id': userData['id']}).toList();

    final roleResponse =
        await _client.from('user_role').upsert(userRoles, ignoreDuplicates: true).execute();

    if (roleResponse.hasError) {
      throw Exception(roleResponse.error);
    }

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
