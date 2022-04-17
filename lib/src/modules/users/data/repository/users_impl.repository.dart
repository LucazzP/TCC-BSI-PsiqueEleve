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
import '../datasource/users.datasource.dart';
import '../../domain/repository/users.repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersDataSource _dataSource;

  const UsersRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, UserEntity>> createUser(UserEntity user, List<String> rolesId) {
    return callEither<UserEntity, Map>(
      () => _dataSource.createUser(user.toMap(onlyUserFields: true), rolesId),
      processResponse: (res) async => res.toEntityEither(UserMapper.fromMap),
    );
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers(
      {required List<UserType> userTypes, int page = 0}) {
    return callEither<List<UserEntity>, List<Map>>(
      () => _dataSource.getUsers(page: page, userTypes: userTypes.map((e) => e.name).toList()),
      processResponse: (res) async => Right(res.map(UserMapper.fromMap).whereNotNull().toList()),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser(UserEntity user, List<String> rolesId) {
    return callEither<UserEntity, Map>(
      () => _dataSource.updateUser(user.toMap(onlyUserFields: true), rolesId),
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
