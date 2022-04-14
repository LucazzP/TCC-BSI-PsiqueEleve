import 'package:supabase_flutter/supabase_flutter.dart';

import 'therapists.datasource.dart';

class TherapistsDataSourceImpl implements TherapistsDataSource {
  final SupabaseClient client;

  const TherapistsDataSourceImpl(this.client);

  static const pageSize = 10;

  @override
  Future<List<Map>> getTherapists({int page = 0}) async {
    final offset = page * pageSize;
    final res = await client.from('user').select('''
      *,
      user_role:role!inner(name)
''').eq('user_role.name', 'therapist').range(0 + offset, 9 + offset).execute();
    return List.castFrom<dynamic, Map>(res.data ?? []);
  }

  @override
  Future<Map> createTherapist(Map therapist) {
    throw UnimplementedError();
  }

  @override
  Future<Map> updateTherapist(Map therapist) {
    throw UnimplementedError();
  }
}
