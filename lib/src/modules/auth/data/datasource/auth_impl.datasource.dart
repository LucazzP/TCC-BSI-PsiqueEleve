import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth.datasource.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final SupabaseClient api;

  const AuthDataSourceImpl(this.api);

  @override
  Future<Map> getUserLogged() async {
    final user = api.auth.currentUser;
    if (user == null) return {};
    final res = await api.from('users').select().eq('id', user.id).limit(1).single().execute();
    return Map.from(res.data);
  }
}
