import 'package:supabase_flutter/supabase_flutter.dart';

import 'users.datasource.dart';

class UsersDataSourceImpl implements UsersDataSource {
  final SupabaseClient client;

  const UsersDataSourceImpl(this.client);

  static const pageSize = 10;

  @override
  Future<List<Map>> getUsers({int page = 0}) async {
    final offset = page * pageSize;
    final res = await client.from('user').select('''
      *,
      user_role:role!inner(name)
''').eq('user_role.name', 'therapist').range(0 + offset, 9 + offset).execute();
    return List.castFrom<dynamic, Map>(res.data ?? []);
  }

  @override
  Future<Map> createUser(Map therapist) {
    throw UnimplementedError();
  }

  @override
  Future<Map> updateUser(Map therapist) {
    throw UnimplementedError();
  }
}
