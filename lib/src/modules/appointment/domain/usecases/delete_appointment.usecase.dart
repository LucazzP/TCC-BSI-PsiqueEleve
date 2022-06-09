import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/appointment/domain/entity/appointment.entity.dart';
import 'package:psique_eleve/src/modules/appointment/domain/repository/appointment.repository.dart';

class DeleteAppointmentUseCase implements BaseUseCase<Unit, AppointmentEntity> {
  final AppointmentRepository _repo;

  const DeleteAppointmentUseCase(this._repo);

  @override
  Future<Either<Failure, Unit>> call(AppointmentEntity appointment) {
    return _repo.deleteAppointment(appointment);
  }
}
