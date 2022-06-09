abstract class TasksRemoteDataSource {
  Future<List<Map>> getTasks(String therapistPatientId);
  Future<Map> getTask(String id);
  Future<Map> createTask(Map task);
  Future<Map> updateTask(Map task);
}
