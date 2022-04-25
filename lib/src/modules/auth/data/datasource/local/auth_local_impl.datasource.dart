import 'package:psique_eleve/src/data/local/hive_client.dart';
import 'auth_local.datasource.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final HiveClient _hiveClient;
  static const box = 'auth';
  static const _userKey = 'user';
  static const _userRoleKey = 'selected_user_role';

  const AuthLocalDataSourceImpl(this._hiveClient);

  @override
  Future<Map> getUserLogged() {
    return _hiveClient.get(box, _userKey).then((value) => value ?? {});
  }

  @override
  Future<Map> saveUserLogged(Map user) async {
    user['saved_at'] = DateTime.now().millisecondsSinceEpoch;
    await _hiveClient.put(box, _userKey, user);
    return getUserLogged();
  }

  @override
  Future<String> getSelectedUserRole() {
    return _hiveClient.get(box, _userRoleKey).then((value) => value ?? '');
  }

  @override
  Future<void> saveSelectedUserRole(String role) {
    return _hiveClient.put(box, _userRoleKey, role);
  }
}
