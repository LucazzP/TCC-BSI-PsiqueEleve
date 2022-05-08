import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/appointment/domain/entity/appointment.entity.dart';
import 'package:psique_eleve/src/modules/appointment/domain/repository/appointment.repository.dart';

class GetAppointmentUseCase implements BaseUseCase<AppointmentEntity, String> {
  final AppointmentRepository _repo;

  const GetAppointmentUseCase(this._repo);

  @override
  Future<Either<Failure, AppointmentEntity>> call(String appointmentId) {
    return _repo.getAppointment(appointmentId);
  }
}
