import 'package:psique_eleve/src/helpers/casters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'address.datasource.dart';

class AddressDataSourceImpl implements AddressDataSource {
  final SupabaseClient _client;

  const AddressDataSourceImpl(this._client);

  @override
  Future<Map> createAddress(Map address) async {
    final res = await _client.from('address').insert(address).execute();

    if (res.hasError) {
      throw Exception(res.error);
    }

    return Casters.toMap(res.data);
  }

  @override
  Future<Map> updateAddress(Map address) async {
    final id = address['id'] as String?;
    if (id == null || id.isEmpty) {
      return createAddress(address);
    }
    final res = await _client.from('address').update(address).eq('id', id).execute();

    if (res.hasError) {
      throw Exception(res.error);
    }

    return Casters.toMap(res.data);
  }
}
