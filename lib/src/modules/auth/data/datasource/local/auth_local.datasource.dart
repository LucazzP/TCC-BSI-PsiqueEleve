abstract class AuthLocalDataSource {
  Future<Map> getUserLogged();
  Future<Map> saveUserLogged(Map user);
  Future<String> getSelectedUserRole();
  Future<void> saveSelectedUserRole(String role);
}
