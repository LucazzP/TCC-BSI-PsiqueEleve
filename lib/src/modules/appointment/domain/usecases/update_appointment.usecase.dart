import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/appointment/domain/entity/appointment.entity.dart';
import 'package:psique_eleve/src/modules/appointment/domain/repository/appointment.repository.dart';

class UpdateAppointmentUseCase implements BaseUseCase<AppointmentEntity, AppointmentEntity> {
  final AppointmentRepository _repo;

  const UpdateAppointmentUseCase(this._repo);

  @override
  Future<Either<Failure, AppointmentEntity>> call(AppointmentEntity appointment) {
    return _repo.updateAppointment(appointment);
  }
}
