abstract class UsersDataSource {
  Future<List<Map>> getUsers({int page = 0});
  Future<Map> updateUser(Map therapist);
  Future<Map> createUser(Map therapist);
}
