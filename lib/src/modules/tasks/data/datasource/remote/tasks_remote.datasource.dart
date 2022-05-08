abstract class TasksRemoteDataSource {
  Future<List<Map>> getTasks();
  Future<Map> getTask(String id);
  Future<Map> createTask(Map task);
  Future<Map> updateTask(Map task);
}
