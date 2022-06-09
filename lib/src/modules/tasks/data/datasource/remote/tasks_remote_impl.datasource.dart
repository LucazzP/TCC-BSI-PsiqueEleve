import 'package:psique_eleve/src/helpers/casters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'tasks_remote.datasource.dart';

class TasksRemoteDataSourceImpl implements TasksRemoteDataSource {
  final SupabaseClient client;
  static const table = 'task';

  const TasksRemoteDataSourceImpl(this.client);

  @override
  Future<Map> getTask(String id) async {
    final res = await client.functions.invoke('get-task', body: {"id": id});

    if (res.error != null) {
      throw Exception(res.error);
    }

    return Casters.toMap(res.data)['data'];
  }

  @override
  Future<List<Map>> getTasks(String therapistPatientId) async {
    final res = await client.functions.invoke('get-tasks',
        body: therapistPatientId.isEmpty ? null : {"therapist_patient_id": therapistPatientId});

    if (res.error != null) {
      throw Exception(res.error);
    }

    return Casters.toListMap(Casters.toMap(res.data)['data']);
  }

  @override
  Future<Map> updateTask(Map task) async {
    final id = task['id'] as String?;
    if (id == null || id.isEmpty) {
      return createTask(task);
    }
    task['therapist_patient_id'] = task['therapist_patient']['id'];
    task.remove('therapist_patient');
    final response = await client.from(table).update(task).eq('id', id).execute();
    if (response.hasError) {
      throw Exception(response.error);
    }
    return getTask(Casters.toMap(response.data)['id']);
  }

  @override
  Future<Map> createTask(Map task) async {
    task['therapist_patient_id'] = task['therapist_patient']['id'];
    task.remove('therapist_patient');
    final response = await client.from(table).insert(task).execute();
    if (response.hasError) {
      throw Exception(response.error);
    }
    return getTask(Casters.toMap(response.data)['id']);
  }
}
