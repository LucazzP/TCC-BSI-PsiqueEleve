import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/modules/appointment/domain/constants/status.enum.dart';
import 'package:psique_eleve/src/modules/appointment/domain/entity/appointment.entity.dart';
import 'package:psique_eleve/src/modules/appointment/domain/usecases/create_appointment.usecase.dart';
import 'package:psique_eleve/src/modules/appointment/domain/usecases/update_appointment.usecase.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
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

  _AddEditAppointmentControllerBase(this._createAppointmentUseCase, this._updateAppointmentUseCase);

  final date = ValueStore<DateTime>(DateTime.now());
  final therapistReport = FormStore((_) => null);
  final patientReport = FormStore((_) => null);
  final responsibleReport = FormStore((_) => null);
  final status = ValueStore<Status>(Status.todo);
  final therapistPatientRelationship = ValueStore<TherapistPatientRelationshipEntity?>(null);

  final newAppointment = ValueState<AppointmentEntity?>(null);

  @override
  Iterable<ValueState> get getStates => [newAppointment];

  @override
  List<FormStore> get getForms => [therapistReport, patientReport, responsibleReport];

  late final String appointmentId;

  bool get pageIsForEditing => appointmentId.isNotEmpty;
  String get getCreateEditValue => pageIsForEditing ? 'Editar' : 'Criar';

  @computed
  String get title => '$getCreateEditValue agendamento';

  Future<void> initialize(AppointmentEntity? appointment) async {
    appointmentId = appointment?.id ?? '';
    if (pageIsForEditing == false) {
      await selectPatient();
      if (therapistPatientRelationship.value == null) Modular.to.pop(false);
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      date.setValue(appointment?.date ?? DateTime.now());
      status.setValue(appointment?.status ?? Status.todo);
      therapistPatientRelationship.setValue(appointment?.therapistPatientRelationship);
      therapistReport.setValue(appointment?.therapistReport ?? '');
      patientReport.setValue(appointment?.patientReport ?? '');
      responsibleReport.setValue(appointment?.responsibleReport ?? '');
    });
  }

  String get getSuccessMessage =>
      pageIsForEditing ? 'Usuário editado com sucesso!' : 'Usuário criado com sucesso!';

  Future<void> selectDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: date.value,
      firstDate: DateTime.fromMillisecondsSinceEpoch(
          min(DateTime.now().millisecondsSinceEpoch, date.value.millisecondsSinceEpoch)),
      lastDate: DateTime(2100),
    );

    if (newDate == null) return;
    date.setValue(newDate);
  }

  Future<void> selectPatient() async {
    final selectedPatient = await UsersPage.navigateToSelect(UserType.patient);
    if (selectedPatient.isEmpty) return;
    therapistPatientRelationship.setValue(selectedPatient.first);
  }

  Future<bool> onTapCreateEdit() async {
    final _therapistPatientRelationship = therapistPatientRelationship.value;
    if (validateForms() == false || _therapistPatientRelationship == null) return false;

    final appointment = AppointmentEntity(
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

    await newAppointment.execute(
      () => pageIsForEditing
          ? _updateAppointmentUseCase(appointment)
          : _createAppointmentUseCase(appointment),
    );

    if (hasFailure) return false;

    Modular.to.pop(true);

    return true;
  }
}
