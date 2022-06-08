import 'package:flinq/flinq.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:psique_eleve/src/extensions/iterable.ext.dart';
import 'package:psique_eleve/src/helpers/casters.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'users.datasource.dart';

class UsersDataSourceImpl implements UsersDataSource {
  final SupabaseClient _client;
  final FlutterSecureStorage _secureStorage;

  const UsersDataSourceImpl(this._client, this._secureStorage);

  static const pageSize = 30;

  @override
  Future<List<Map>> getUsers({
    required List<String> userTypes,
    required UserType activeUserRole,
    required String loggedUserId,
    int page = 0,
  }) async {
    final offset = page * pageSize;
    List<PostgrestTransformBuilder> queries = [];
    if (userTypes.contains(UserType.therapist.name)) {
      queries.add(
        _client.from('user').select('''
          *,
          roles_user:role!inner(name)
        ''').eq('roles_user.name', UserType.therapist.name),
      );
    }
    if (userTypes.contains(UserType.patient.name)) {
      final shouldFilterByLinkedPatients = activeUserRole == UserType.therapist;
      var query = _client.from('patient_view').select('*');
      if (shouldFilterByLinkedPatients) {
        query = query.eq('therapist_id', loggedUserId);
      }
      queries.add(query);
    }
    if (userTypes.contains(UserType.responsible.name)) {
      queries.add(_client.from('responsible_view').select('*'));
    }

    final responses = await Future.wait(
      queries.map((e) => e.range(0 + offset, pageSize + offset).execute()),
    );

    final resWithError = responses.firstOrNullWhere((e) => e.hasError);
    if (resWithError != null) {
      throw Exception(resWithError.error);
    }

    final resultList = responses.map((e) => Casters.toListMap(e.data)).reduce((a, b) => a + b);

    for (final user in resultList) {
      user.remove('therapist');
      user.remove('user_role');
    }

    return resultList.removeEqualIds();
  }

  @override
  Future<Map> getUser(String userId, {String userRole = ''}) async {
    final res = await _client.functions.invoke('get-user', body: {
      "user_id": userId,
      "user_role": userRole,
    });

    if (res.error != null) {
      throw Exception(res.error);
    }

    final user = Casters.toMap(res.data)['data'];

    return user;
  }

  @override
  Future<Map> createUser(Map user, List<Map> roles, UserType activeUserRole) async {
    final loggedEmail = await _secureStorage.read(key: 'email') ?? '';
    final loggedPassword = await _secureStorage.read(key: 'password') ?? '';

    if (loggedPassword.isEmpty || loggedEmail.isEmpty) {
      throw Exception('Você precisa estar logado para criar um usuário');
    }

    /// Create user login

    final password = RandomPasswordGenerator().randomPassword(
      letters: true,
      numbers: true,
      passwordLength: 8,
      specialChar: false,
      uppercase: false,
    );

    final userSession = await _client.auth.signUp(user['email'], password);
    await _client.auth.signIn(email: loggedEmail, password: loggedPassword);

    final userId = userSession.user?.id;

    if (userSession.error != null || userId == null) {
      throw Exception(userSession.error ?? 'Unknown error');
    }

    user['id'] = userId;

    /// Create user on database

    final userResponse = await _client.from('user').insert(user).execute();

    final userData = Casters.toMap(userResponse.data);

    if (userResponse.hasError) {
      throw Exception(userResponse.error ?? 'Unknown error');
    }

    String therapistUserId = '';
    String patientUserId = '';
    final userWillBePatient = roles.any((element) => element['name'] == UserType.patient.name);

    if (activeUserRole == UserType.therapist && userWillBePatient) {
      patientUserId = userId;
      therapistUserId = _client.auth.currentUser?.id ?? '';
    }

    final rolesId = roles.map((role) => role['id'] as String).toList();

    await Future.wait([
      _createUpdateUserRoles(rolesId, userId),
      if (patientUserId.isNotEmpty)
        _createUpdateTherapistPatientRelation(
          therapistUserId: therapistUserId,
          patientUserId: patientUserId,
          active: true,
        ),
    ]);

    userData['password'] = password;

    return userData;
  }

  @override
  Future<Map> updateUser(
    Map user,
    List<Map> roles,
    UserType activeUserRole, {
    String therapistIdLinked = '',
    List<String> responsiblesIdLinked = const [],
  }) async {
    final id = user['id'] as String?;
    if (id == null || id.isEmpty) {
      return createUser(user, roles, activeUserRole);
    }
    PostgrestResponse res = const PostgrestResponse();
    final rolesId = roles.map((role) => role['id'] as String).toList();

    await Future.wait([
      _createUpdateUserRoles(rolesId, id),
      // if (therapistPatientRelationship.isNotEmpty)
      //   _createUpdateTherapistPatientRelation(
      //     id: therapistPatientRelationship['id'],
      //     therapistUserId: therapistPatientRelationship['therapist_user_id'],
      //     patientUserId: therapistPatientRelationship['patient_user_id'],
      //     active: therapistPatientRelationship['active'],
      //   ),
      _client.from('user').update(user).eq('id', id).execute().then((value) {
        res = value;
        return value;
      }),
    ]);

    if (res.hasError) {
      throw Exception(res.error ?? 'Unknown error');
    }
    return Casters.toMap(res.data);
  }

  @override
  Future<List<Map>> getRoles(List<String> names) async {
    final res = await _client.from('role').select('*').in_('name', names).execute();

    if (res.hasError) {
      throw Exception(res.error);
    }

    return Casters.toListMap(res.data);
  }

  Future<List<Map>> _createUpdateUserRoles(List<String> rolesId, String userId) async {
    final userRoles = rolesId.map((role) => {'role_id': role, 'user_id': userId}).toList();

    final roleResponse =
        await _client.from('user_role').upsert(userRoles, ignoreDuplicates: true).execute();

    final error = roleResponse.error;
    if (error != null && !error.message.contains('duplicate key')) {
      throw Exception(roleResponse.error);
    }

    return Casters.toListMap(roleResponse.data);
  }

  Future<Map> _createUpdateTherapistPatientRelation({
    String? id,
    required String therapistUserId,
    required String patientUserId,
    required bool active,
  }) async {
    final therapistPatientRelation = {
      if (id != null) 'id': id,
      'therapist_user_id': therapistUserId,
      'patient_user_id': patientUserId,
      'active': active,
    };
    var query =
        _client.from('therapist_patient').upsert(therapistPatientRelation, ignoreDuplicates: true);
    final res = await query.execute();

    final error = res.error;
    if (error != null && !error.message.contains('duplicate key')) {
      throw Exception(res.error);
    }

    return Casters.toMap(res.data);
  }
}
