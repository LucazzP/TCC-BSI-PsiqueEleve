import 'package:psique_eleve/src/helpers/casters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'appointment_remote.datasource.dart';

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final SupabaseClient client;
  static const table = 'appointment';

  const AppointmentRemoteDataSourceImpl(this.client);

  @override
  Future<Map> createAppointment(Map appointment) async {
    final response = await client.from(table).insert(appointment).execute();
    if (response.hasError) {
      throw Exception(response.error);
    }
    return Casters.toMap(response.data);
  }

  @override
  Future<Map> getAppointment(String id) async {
    final response = await client.from(table).select('*').eq('id', id).single().execute();
    if (response.hasError) {
      throw Exception(response.error);
    }
    return Casters.toMap(response.data);
  }

  @override
  Future<List<Map>> getAppointments() async {
    final response = await client.from(table).select('*').execute();
    if (response.hasError) {
      throw Exception(response.error);
    }
    return Casters.toListMap(response.data);
  }

  @override
  Future<Map> updateAppointment(Map appointment) async {
    final id = appointment['id'] as String?;
    if (id == null || id.isEmpty) {
      return createAppointment(appointment);
    }
    final response = await client.from(table).update(appointment).eq('id', id).execute();
    if (response.hasError) {
      throw Exception(response.error);
    }
    return Casters.toMap(response.data);
  }
}
