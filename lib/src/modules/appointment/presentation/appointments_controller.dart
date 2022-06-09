import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/modules/appointment/domain/entity/appointment.entity.dart';
import 'package:psique_eleve/src/modules/appointment/domain/usecases/get_appointments.usecase.dart';
import 'package:psique_eleve/src/modules/appointment/presentation/add_edit_appointment/add_edit_appointment_page.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/role_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_active_user_role.usecase.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';

part 'appointments_controller.g.dart';

class AppointmentsController = _AppointmentsControllerBase with _$AppointmentsController;

abstract class _AppointmentsControllerBase extends BaseStore with Store {
  final GetAppointmentsUseCase _getAppointmentsUseCase;
  final GetActiveUserRoleUseCase _getActiveUserRoleUseCase;

  _AppointmentsControllerBase(this._getAppointmentsUseCase, this._getActiveUserRoleUseCase);

  final appointments = ValueState<List<AppointmentEntity>>([]);
  final selectedUserRole = ValueState<RoleEntity?>(null);

  @override
  Iterable<ValueState> get getStates => [appointments, selectedUserRole];

  void init() {
    getAppointments();
    getActiveUserRole();
  }

  Future<void> getActiveUserRole() => selectedUserRole.execute(_getActiveUserRoleUseCase.asEither);

  Future<void> getAppointments([bool shouldSetLoading = true]) => appointments.execute(
        _getAppointmentsUseCase,
        shouldSetToInitialValue: false,
        shouldSetLoading: shouldSetLoading,
      );

  @computed
  bool get shouldShowCreateButton => selectedUserRole.value?.canManageAppointments == true;

  Future<void> onTapAddEditAppointment([AppointmentEntity? appointment]) async {
    final editted = await AddEditAppointmentPage.navigateTo(appointment);
    if (editted == true) return getAppointments();
  }
}
