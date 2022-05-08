import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/modules/appointment/domain/entity/appointment.entity.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, AppointmentEntity>> createAppointment(AppointmentEntity appointment);
  Future<Either<Failure, AppointmentEntity>> getAppointment(String id);
  Future<Either<Failure, List<AppointmentEntity>>> getAppointments();
  Future<Either<Failure, AppointmentEntity>> updateAppointment(AppointmentEntity appointment);
}
