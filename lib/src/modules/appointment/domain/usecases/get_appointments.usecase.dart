import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/appointment/domain/entity/appointment.entity.dart';
import 'package:psique_eleve/src/modules/appointment/domain/repository/appointment.repository.dart';

class GetAppointmentsUseCase implements BaseUseCase<List<AppointmentEntity>, Unit> {
  final AppointmentRepository _repo;

  const GetAppointmentsUseCase(this._repo);

  @override
  Future<Either<Failure, List<AppointmentEntity>>> call([Unit param = unit]) {
    return _repo.getAppointments();
  }
}
