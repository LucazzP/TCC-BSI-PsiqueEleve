import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/extensions/date_time.ext.dart';
import 'package:psique_eleve/src/modules/appointment/domain/constants/status.enum.dart';
import 'package:psique_eleve/src/modules/appointment/domain/entity/appointment.entity.dart';
import 'package:psique_eleve/src/modules/appointment/domain/usecases/create_appointment.usecase.dart';
import 'package:psique_eleve/src/modules/appointment/domain/usecases/delete_appointment.usecase.dart';
import 'package:psique_eleve/src/modules/appointment/domain/usecases/update_appointment.usecase.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/role_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_active_user_role.usecase.dart';
import 'package:psique_eleve/src/modules/tasks/presentation/tasks_page.dart';
import 'package:psique_eleve/src/modules/users/domain/entities/therapist_patient_relationship.entity.dart';
import 'package:psique_eleve/src/modules/users/presentation/users/users_page.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/form.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';

part 'add_edit_appointment_controller.g.dart';

class AddEditAppointmentController = _AddEditAppointmentControllerBase
    with _$AddEditAppointmentController;

abstract class _AddEditAppointmentControllerBase extends BaseStore with Store {
  final CreateAppointmentUseCase _createAppointmentUseCase;
  final UpdateAppointmentUseCase _updateAppointmentUseCase;
  final DeleteAppointmentUseCase _deleteAppointmentUseCase;
  final GetActiveUserRoleUseCase _getActiveUserRoleUseCase;

  _AddEditAppointmentControllerBase(
    this._createAppointmentUseCase,
    this._updateAppointmentUseCase,
    this._getActiveUserRoleUseCase,
    this._deleteAppointmentUseCase,
  );

  final date = ValueStore<DateTime>(DateTime.now().next30Minutes());
  final therapistReport = FormStore((_) => null);
  final patientReport = FormStore((_) => null);
  final responsibleReport = FormStore((_) => null);
  final status = ValueStore<Status>(Status.todo);
  final therapistPatientRelationship = ValueStore<TherapistPatientRelationshipEntity?>(null);

  final newAppointment = ValueState<AppointmentEntity?>(null);
  final selectedUserRole = ValueState<RoleEntity?>(null);

  @override
  Iterable<ValueState> get getStates => [newAppointment, selectedUserRole];

  @override
  List<FormStore> get getForms => [therapistReport, patientReport, responsibleReport];

  late final String appointmentId;

  bool get pageIsForEditing => appointmentId.isNotEmpty;
  String get getCreateEditValue => pageIsForEditing ? 'Editar' : 'Criar';

  @computed
  String get title => isOnlyView ? 'Agendamento' : '$getCreateEditValue agendamento';

  @computed
  bool get shouldShowGoToTasksButton =>
      therapistPatientRelationship.value != null && selectedUserRole.value?.canManageTasks == true;

  @computed
  bool get isOnlyView =>
      selectedUserRole.value?.canManageAppointments == false &&
      selectedUserRole.value?.canManageTasks == false;

  @computed
  bool get shouldShowDeleteButton => pageIsForEditing && !isOnlyView && status.value == Status.todo;

  Future<void> initialize(AppointmentEntity? appointment) async {
    appointmentId = appointment?.id ?? '';
    getActiveUserRole().ignore();
    if (pageIsForEditing == false) {
      await selectPatient();
      if (therapistPatientRelationship.value == null) Modular.to.pop(false);
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      date.setValue(appointment?.date ?? DateTime.now().next30Minutes());
      status.setValue(appointment?.status ?? Status.todo);
      therapistPatientRelationship.setValue(appointment?.therapistPatientRelationship);
      therapistReport.setValue(appointment?.therapistReport ?? '');
      patientReport.setValue(appointment?.patientReport ?? '');
      responsibleReport.setValue(appointment?.responsibleReport ?? '');
    });
  }

  String get getSuccessMessage =>
      pageIsForEditing ? 'Consulta editada com sucesso!' : 'Consulta criada com sucesso!';

  Future<void> selectDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: date.value,
      firstDate: DateTime.fromMillisecondsSinceEpoch(
          min(DateTime.now().millisecondsSinceEpoch, date.value.millisecondsSinceEpoch)),
      lastDate: DateTime(2100),
    );
    if (newDate == null) return;

    await Future.delayed(const Duration(milliseconds: 200));
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(date.value),
    );
    if (time == null) return;

    date.setValue(DateTime(newDate.year, newDate.month, newDate.day, time.hour, time.minute));
  }

  Future<void> selectPatient() async {
    final selectedPatient = await UsersPage.navigateToSelect(UserType.patient);
    if (selectedPatient.isEmpty) return;
    therapistPatientRelationship.setValue(selectedPatient.first);
  }

  Future<bool> onTapCreateEdit() async {
    final _appointment = appointment;
    if (validateForms() == false || _appointment == null) return false;

    await newAppointment.execute(
      () => pageIsForEditing
          ? _updateAppointmentUseCase(_appointment)
          : _createAppointmentUseCase(_appointment),
    );

    if (hasFailure) return false;

    Modular.to.pop(true);

    return true;
  }

  void onTapGoToTasks() {
    final _therapistPatientRelationship = therapistPatientRelationship.value;
    if (_therapistPatientRelationship == null) return;
    TasksPage.navigateToNewPage(_therapistPatientRelationship);
  }

  Future<void> getActiveUserRole() => selectedUserRole.execute(_getActiveUserRoleUseCase.asEither);

  void onTapDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir consulta'),
        content: const Text('Tem certeza que deseja excluir esta consulta?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Excluir'),
            onPressed: () async {
              Navigator.of(context).pop();
              final _appointment = appointment;
              if (_appointment == null) return;
              await newAppointment.execute(
                () => _deleteAppointmentUseCase
                    .call(_appointment)
                    .then((value) => value.map((r) => null)),
              );
              if (hasFailure) return;
              Modular.to.pop(true);
            },
          ),
        ],
      ),
    );
  }

  AppointmentEntity? get appointment {
    final _therapistPatientRelationship = therapistPatientRelationship.value;
    if (_therapistPatientRelationship == null) return null;
    return AppointmentEntity(
      id: appointmentId,
      date: date.value,
      therapistReport: therapistReport.value,
      patientReport: patientReport.value,
      responsibleReport: responsibleReport.value,
      therapistPatientRelationship: _therapistPatientRelationship,
      xp: 5,
      status: status.value,
      createdAt: DateTime.now(),
    );
  }
}
