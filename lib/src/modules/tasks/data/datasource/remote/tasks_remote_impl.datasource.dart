import 'package:psique_eleve/src/helpers/casters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'tasks_remote.datasource.dart';

class TasksRemoteDataSourceImpl implements TasksRemoteDataSource {
  final SupabaseClient client;
  static const table = 'task';

  const TasksRemoteDataSourceImpl(this.client);

  @override
  Future<Map> createTask(Map task) async {
    final response = await client.from(table).insert(task).execute();
    if (response.hasError) {
      throw Exception(response.error);
    }
    return Casters.toMap(response.data);
  }

  @override
  Future<Map> getTask(String id) async {
    final response = await client.from(table).select('*').eq('id', id).single().execute();
    if (response.hasError) {
      throw Exception(response.error);
    }
    return Casters.toMap(response.data);
  }

  @override
  Future<List<Map>> getTasks() async {
    final response = await client.from(table).select('*').execute();
    if (response.hasError) {
      throw Exception(response.error);
    }
    return Casters.toListMap(response.data);
  }

  @override
  Future<Map> updateTask(Map task) async {
    final id = task['id'] as String?;
    if (id == null || id.isEmpty) {
      return createTask(task);
    }
    final response = await client.from(table).update(task).eq('id', id).execute();
    if (response.hasError) {
      throw Exception(response.error);
    }
    return Casters.toMap(response.data);
  }
}
