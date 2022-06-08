import 'package:psique_eleve/src/helpers/casters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'appointment_remote.datasource.dart';

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final SupabaseClient client;
  static const table = 'appointment';

  const AppointmentRemoteDataSourceImpl(this.client);

  @override
  Future<Map> getAppointment(String id) async {
    final res = await client.functions.invoke('get-appointment', body: {"id": id});

    if (res.error != null) {
      throw Exception(res.error);
    }

    return Casters.toMap(res.data)['data'];
  }

  @override
  Future<List<Map>> getAppointments() async {
    final res = await client.functions.invoke('get-appointments');

    if (res.error != null) {
      throw Exception(res.error);
    }

    return Casters.toListMap(Casters.toMap(res.data)['data']);
  }

  @override
  Future<Map> updateAppointment(Map appointment) async {
    final id = appointment['id'] as String?;
    if (id == null || id.isEmpty) {
      return createAppointment(appointment);
    }
    appointment['therapist_patient_id'] = appointment['therapist_patient']['id'];
    appointment.remove('therapist_patient');
    final response = await client.from(table).update(appointment).eq('id', id).execute();
    if (response.hasError) {
      throw Exception(response.error);
    }
    return getAppointment(Casters.toMap(response.data)['id']);
  }

  @override
  Future<Map> createAppointment(Map appointment) async {
    appointment['therapist_patient_id'] = appointment['therapist_patient']['id'];
    appointment.remove('therapist_patient');
    final response = await client.from(table).insert(appointment).execute();
    if (response.hasError) {
      throw Exception(response.error);
    }
    return getAppointment(Casters.toMap(response.data)['id']);
  }
}
