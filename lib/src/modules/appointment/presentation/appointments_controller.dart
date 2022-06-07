import 'package:psique_eleve/src/modules/appointment/domain/entity/appointment.entity.dart';
import 'package:psique_eleve/src/modules/appointment/domain/usecases/get_appointments.usecase.dart';
import 'package:psique_eleve/src/modules/appointment/presentation/add_edit_appointment/add_edit_appointment_page.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:mobx/mobx.dart';

part 'appointments_controller.g.dart';

class AppointmentsController = _AppointmentsControllerBase with _$AppointmentsController;

abstract class _AppointmentsControllerBase extends BaseStore with Store {
  final GetAppointmentsUseCase _getAppointmentsUseCase;

  _AppointmentsControllerBase(this._getAppointmentsUseCase);

  final appointments = ValueState<List<AppointmentEntity>>([]);
  @override
  Iterable<ValueState> get getStates => [appointments];

  void getAppointments() async {
    return appointments.execute(_getAppointmentsUseCase);
  }

  Future<void> onTapAddEditAppointment([AppointmentEntity? appointment]) =>
      AddEditAppointmentPage.navigateTo(appointment);
}
