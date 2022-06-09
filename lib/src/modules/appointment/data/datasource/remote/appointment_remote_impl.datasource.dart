import 'package:psique_eleve/src/core/failures.dart';
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
    final failure = await _canCreateUpdateOnDateRange(appointment);
    if (failure != null && kHourOnPastAppointmentFailure != failure) {
      throw failure;
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
    final failure = await _canCreateUpdateOnDateRange(appointment);
    if (failure != null) throw failure;

    appointment['therapist_patient_id'] = appointment['therapist_patient']['id'];
    appointment.remove('therapist_patient');
    final response = await client.from(table).insert(appointment).execute();
    if (response.hasError) {
      throw Exception(response.error);
    }
    return getAppointment(Casters.toMap(response.data)['id']);
  }

  Future<Failure?> _canCreateUpdateOnDateRange(Map appointment) async {
    final appointmentDate = DateTime.tryParse(appointment['date'] as String);
    final userId = appointment['therapist_patient']['therapist_user']['id'];
    if (appointmentDate != null && userId is String && userId.isNotEmpty) {
      if (appointmentDate.isBefore(DateTime.now())) {
        return kHourOnPastAppointmentFailure;
      }
      final from = appointmentDate.subtract(const Duration(minutes: 29)).toIso8601String();
      final to = appointmentDate.add(const Duration(minutes: 30)).toIso8601String();
      final res = await client
          .from(table)
          .select('id, date, therapist_patient!inner(*)')
          .eq('therapist_patient.therapist_user_id', userId)
          .gte('date', from)
          .lt('date', to)
          .not('id', 'eq', appointment['id'])
          .execute();
      if (res.hasError) {
        throw Exception(res.error);
      }
      final appointments = Casters.toListMap(res.data);
      if (appointments.isNotEmpty) {
        return kAlreadyUsedHourAppointmentFailure;
      }
    }
  }

  @override
  Future<Map> deleteAppointment(Map appointment) async {
    final id = appointment['id'] as String?;
    if (id == null || id.isEmpty) throw Exception('id is required');
    final response = await client.from(table).delete().eq('id', id).execute();
    if (response.hasError) {
      throw Exception(response.error);
    }
    return {};
  }
}
