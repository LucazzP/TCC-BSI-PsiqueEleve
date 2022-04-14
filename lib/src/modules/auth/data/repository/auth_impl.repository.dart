import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/data/utils/call_either.dart';
import 'package:psique_eleve/src/extensions/map.ext.dart';
import 'package:psique_eleve/src/modules/auth/data/datasource/local/auth_local.datasource.dart';
import 'package:psique_eleve/src/modules/auth/data/mappers/user_mapper.dart';
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
        if (localUser.isNotEmpty) return localUser;
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
}
