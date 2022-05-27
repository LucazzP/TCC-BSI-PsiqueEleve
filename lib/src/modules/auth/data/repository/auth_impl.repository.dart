import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flinq/flinq.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/data/utils/call_either.dart';
import 'package:psique_eleve/src/extensions/iterable.ext.dart';
import 'package:psique_eleve/src/extensions/map.ext.dart';
import 'package:psique_eleve/src/modules/auth/data/datasource/local/auth_local.datasource.dart';
import 'package:psique_eleve/src/modules/auth/data/mappers/role_mapper.dart';
import 'package:psique_eleve/src/modules/auth/data/mappers/user_mapper.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/role_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import '../datasource/remote/auth_remote.datasource.dart';
import '../../domain/repository/auth.repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  const AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, UserEntity?>> getUserLogged() {
    return callEither<UserEntity?, Map>(
      () async {
        final localUser = await _localDataSource.getUserLogged();
        if (localUser.isNotEmpty) {
          if (localUser['saved_at'] != null) {
            final savedAt = DateTime.fromMillisecondsSinceEpoch(localUser['saved_at']);
            final now = DateTime.now();
            if (now.difference(savedAt).inMinutes > 10) {
              updateLocalUserWithRemote();
            }
          }
          return localUser;
        }
        return _remoteDataSource.getUserLogged();
      },
      processResponse: (res) async {
        final user = UserMapper.fromMap(res);
        if (user != null) await _localDataSource.saveUserLogged(res);
        return Right(user);
      },
    );
  }

  @override
  Future<void> updateLocalUserWithRemote() {
    return _remoteDataSource.getUserLogged().then((res) async {
      if (res.isNotEmpty) await _localDataSource.saveUserLogged(res);
    });
  }

  @override
  Future<Either<Failure, UserEntity>> loginEmail(
      {required String email, required String password}) {
    return callEither<UserEntity, Map>(
      () => _remoteDataSource.loginEmail(email: email, password: password),
      processResponse: (res) async {
        final user = res.toEntityEither(UserMapper.fromMap);
        if (user.isLeft()) return user;
        await _localDataSource.saveUserLogged(res);
        return user;
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> logout() {
    return callEither(() async {
      await _remoteDataSource.logout();
      _localDataSource.saveUserLogged({});
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> resetLocalUser() {
    return callEither(() async {
      await _localDataSource.saveUserLogged({});
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> recoverPassword(String email) {
    return callEither(
      () => _remoteDataSource.recoverPassword(email),
      onError: (error) {
        if (error.toString().contains('User not found')) {
          return kUserNotFoundResetPasswordFailure;
        }
        return kServerFailure;
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> changePassword(String password) {
    return callEither(() => _remoteDataSource.changePassword(password));
  }

  @override
  Future<Either<Failure, UserType>> getSelectedUserRole() {
    return callEither<UserType, UserType>(() async {
      final selectedUserRole = await _localDataSource.getSelectedUserRole();
      final _selectedRole = UserType.values.firstOrNullWhere((e) => e.name == selectedUserRole);
      if (_selectedRole != null) return _selectedRole;

      final localUser = await _localDataSource.getUserLogged();
      final userRole = UserMapper.fromMap(localUser)?.role.type ?? UserType.patient;
      return userRole;
    });
  }

  @override
  Future<Either<Failure, Unit>> setSelectedUserRole(UserType userType) {
    return callEither(() async {
      await _localDataSource.saveSelectedUserRole(userType.name);
      return unit;
    });
  }

  @override
  Future<Either<Failure, List<RoleEntity>>> getRoles() {
    return callEither<List<RoleEntity>, List<Map>>(
      () => _remoteDataSource.getRoles(),
      processResponse: (res) async => Right(res.map(RoleMapper.fromMap).whereNotNull().toList()),
    );
  }
}
