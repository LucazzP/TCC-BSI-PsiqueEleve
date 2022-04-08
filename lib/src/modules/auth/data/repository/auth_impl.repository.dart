import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/data/utils/call_either.dart';
import 'package:psique_eleve/src/modules/auth/data/mappers/user_mapper.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import '../datasource/auth.datasource.dart';
import '../../domain/repository/auth.repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;

  const AuthRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, UserEntity?>> getUserLogged() {
    return callEither<UserEntity?, Map>(
      _dataSource.getUserLogged,
      processResponse: (res) async => Right(UserMapper.fromMap(res)),
    );
  }
}
