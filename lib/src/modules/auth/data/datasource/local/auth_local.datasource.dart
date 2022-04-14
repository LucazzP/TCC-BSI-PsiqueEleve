abstract class AuthLocalDataSource {
  Future<Map> getUserLogged();
  Future<Map> saveUserLogged(Map user);
}
