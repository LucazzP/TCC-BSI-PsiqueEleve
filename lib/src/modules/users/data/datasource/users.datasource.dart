import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';

abstract class UsersDataSource {
  Future<List<Map>> getUsers({
    required List<String> userTypes,
    required UserType activeUserRole,
    required String loggedUserId,
    int page = 0,
  });
  Future<Map> getUser(String userId, {String userRole = ''});
  Future<Map> updateUser(
    Map user,
    List<Map> roles,
    UserType activeUserRole,
    Map therapistPatientRelationship, {
    List<Map> responsiblesRelationship = const [],
  });
  Future<Map> createUser(Map user, List<Map> roles, UserType activeUserRole);
  Future<List<Map>> getRoles(List<String> names);
}
