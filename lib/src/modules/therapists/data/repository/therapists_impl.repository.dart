import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/data/utils/call_either.dart';
import 'package:psique_eleve/src/extensions/iterable.ext.dart';
import 'package:psique_eleve/src/extensions/map.ext.dart';
import 'package:psique_eleve/src/modules/auth/data/mappers/user_mapper.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import '../datasource/therapists.datasource.dart';
import '../../domain/repository/therapists.repository.dart';

class TherapistsRepositoryImpl implements TherapistsRepository {
  final TherapistsDataSource _dataSource;

  const TherapistsRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, UserEntity>> createTherapist(UserEntity therapist) {
    return callEither<UserEntity, Map>(
      () => _dataSource.createTherapist(therapist.toMap()),
      processResponse: (res) async => res.toEntityEither(UserMapper.fromMap),
    );
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getTherapists({int page = 0}) {
    return callEither<List<UserEntity>, List<Map>>(
      () => _dataSource.getTherapists(page: page),
      processResponse: (res) async => Right(res.map(UserMapper.fromMap).whereNotNull().toList()),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> updateTherapist(UserEntity therapist) {
    return callEither<UserEntity, Map>(
      () => _dataSource.updateTherapist(therapist.toMap()),
      processResponse: (res) async => res.toEntityEither(UserMapper.fromMap),
    );
  }
}
