abstract class UsersDataSource {
  Future<List<Map>> getUsers({required List<String> userTypes, int page = 0});
  Future<Map> updateUser(Map user, List<String> rolesId);
  Future<Map> createUser(Map user, List<String> rolesId);
  Future<List<Map>> getRoles(List<String> names);
}
