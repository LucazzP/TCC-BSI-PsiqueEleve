import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/data/utils/call_either.dart';
import 'package:psique_eleve/src/extensions/iterable.ext.dart';
import 'package:psique_eleve/src/extensions/map.ext.dart';
import 'package:psique_eleve/src/modules/auth/data/mappers/role_mapper.dart';
import 'package:psique_eleve/src/modules/auth/data/mappers/user_mapper.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/role_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/users/data/mappers/therapist_patient_relationship.mapper.dart';
import 'package:psique_eleve/src/modules/users/domain/entities/therapist_patient_relationship.entity.dart';

import '../../domain/repository/users.repository.dart';
import '../datasource/users.datasource.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersDataSource _dataSource;

  const UsersRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, UserEntity>> createUser(
      UserEntity user, List<RoleEntity> roles, UserType activeUserRole) {
    return callEither<UserEntity, Map>(
      () => _dataSource.createUser(
        user.toMap(onlyUserFields: true)..remove('created_at'),
        roles.map((e) => e.toMap()).toList(),
        activeUserRole,
      ),
      processResponse: (res) async => res.toEntityEither(UserMapper.fromMap),
    );
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers({
    required List<UserType> userTypes,
    required UserType activeUserRole,
    required String loggedUserId,
    int page = 0,
  }) {
    return callEither<List<UserEntity>, List<Map>>(
      () => _dataSource.getUsers(
        page: page,
        userTypes: userTypes.map((e) => e.name).toList(),
        activeUserRole: activeUserRole,
        loggedUserId: loggedUserId,
      ),
      processResponse: (res) async => Right(res.map(UserMapper.fromMap).whereNotNull().toList()),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> getUser(String userId, {String userRole = ''}) {
    return callEither<UserEntity, Map>(
      () => _dataSource.getUser(userId, userRole: userRole),
      processResponse: (res) async => res.toEntityEither(UserMapper.fromMap),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser(
    UserEntity user,
    List<RoleEntity> roles,
    UserType activeUserRole,
    TherapistPatientRelationshipEntity therapistPatientRelationship, {
    List<TherapistPatientRelationshipEntity> responsiblesRelationship = const [],
  }) {
    return callEither<UserEntity, Map>(
      () => _dataSource.updateUser(
        user.toMap(onlyUserFields: true)..remove('created_at'),
        roles.map((e) => e.toMap()).toList(),
        activeUserRole,
        therapistPatientRelationship.toMap(onlyUserFields: true),
        responsiblesRelationship:
            responsiblesRelationship.map((e) => e.toMap(onlyUserFields: true)).toList(),
      ),
      processResponse: (res) async => res.toEntityEither(UserMapper.fromMap),
    );
  }

  @override
  Future<Either<Failure, List<RoleEntity>>> getRoles(List<UserType> userTypes) {
    return callEither<List<RoleEntity>, List<Map>>(
      () => _dataSource.getRoles(userTypes.map((e) => e.name).toList()),
      processResponse: (res) async => Right(res.map(RoleMapper.fromMap).whereNotNull().toList()),
    );
  }
}
