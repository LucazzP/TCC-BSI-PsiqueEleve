import 'package:psique_eleve/src/data/local/hive_client.dart';
import 'auth_local.datasource.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final HiveClient _hiveClient;
  static const box = 'auth';
  static const _userKey = 'user';

  const AuthLocalDataSourceImpl(this._hiveClient);

  @override
  Future<Map> getUserLogged() {
    return _hiveClient.get(box, _userKey).then((value) => value ?? {});
  }

  @override
  Future<Map> saveUserLogged(Map user) async {
    await _hiveClient.put(box, _userKey, user);
    return getUserLogged();
  }
}
