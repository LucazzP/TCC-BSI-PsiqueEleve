import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/data/utils/call_either.dart';
import 'package:psique_eleve/src/extensions/iterable.ext.dart';
import 'package:psique_eleve/src/extensions/map.ext.dart';
import 'package:psique_eleve/src/modules/appointment/data/mapper/appointment.mapper.dart';
import 'package:psique_eleve/src/modules/appointment/domain/entity/appointment.entity.dart';

import '../../domain/repository/appointment.repository.dart';
import '../datasource/remote/appointment_remote.datasource.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentRemoteDataSource _dataSource;

  const AppointmentRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, AppointmentEntity>> createAppointment(AppointmentEntity appointment) {
    return callEither<AppointmentEntity, Map>(
      () => _dataSource.createAppointment(appointment.toMap()),
      processResponse: (res) async => res.toEntityEither(AppointmentMapper.fromMap),
    );
  }

  @override
  Future<Either<Failure, AppointmentEntity>> getAppointment(String id) {
    return callEither<AppointmentEntity, Map>(
      () => _dataSource.getAppointment(id),
      processResponse: (res) async => res.toEntityEither(AppointmentMapper.fromMap),
    );
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getAppointments() {
    return callEither<List<AppointmentEntity>, List<Map>>(
      () => _dataSource.getAppointments(),
      processResponse: (res) async =>
          Right(res.map(AppointmentMapper.fromMap).whereNotNull().toList()),
    );
  }

  @override
  Future<Either<Failure, AppointmentEntity>> updateAppointment(AppointmentEntity appointment) {
    return callEither<AppointmentEntity, Map>(
      () => _dataSource.updateAppointment(appointment.toMap()),
      processResponse: (res) async => res.toEntityEither(AppointmentMapper.fromMap),
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteAppointment(AppointmentEntity appointment) {
    return callEither<Unit, Map>(
      () => _dataSource.deleteAppointment(appointment.toMap()),
      processResponse: (res) async => const Right(unit),
    );
  }
}
