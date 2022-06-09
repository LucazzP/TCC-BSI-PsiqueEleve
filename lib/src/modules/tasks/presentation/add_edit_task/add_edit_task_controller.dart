import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/modules/appointment/domain/constants/status.enum.dart';
import 'package:psique_eleve/src/modules/tasks/domain/entity/task.entity.dart';
import 'package:psique_eleve/src/modules/tasks/domain/usecases/create_task.usecase.dart';
import 'package:psique_eleve/src/modules/tasks/domain/usecases/update_task.usecase.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/form.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:psique_eleve/src/presentation/constants/validators.dart';

part 'add_edit_task_controller.g.dart';

class AddEditTaskController = _AddEditTaskControllerBase with _$AddEditTaskController;

abstract class _AddEditTaskControllerBase extends BaseStore with Store {
  final CreateTaskUseCase _createTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;

  _AddEditTaskControllerBase(this._createTaskUseCase, this._updateTaskUseCase);

  final date = ValueStore<DateTime>(DateTime.now());

  final taskTitle = FormStore(Validators.minLenght(3));
  final status = ValueStore<Status>(Status.todo);

  final newTask = ValueState<TaskEntity?>(null);

  @override
  Iterable<ValueState> get getStates => [newTask];

  @override
  List<FormStore> get getForms => [taskTitle];

  late final String taskId;

  bool get pageIsForEditing => taskId.isNotEmpty;
  String get getCreateEditValue => pageIsForEditing ? 'Editar' : 'Criar';

  String get getSuccessMessage =>
      pageIsForEditing ? 'Usuário editado com sucesso!' : 'Usuário criado com sucesso!';

  @computed
  String get title => '$getCreateEditValue tarefa';

  Future<void> initialize(TaskEntity? task) async {
    taskId = task?.id ?? '';

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //date.setValue(task?. ?? DateTime.now());
      status.setValue(task?.status ?? Status.todo);
      taskTitle.setValue(task?.task ?? "");
    });
  }

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

  Future<bool> onTapCreateEdit() async {
    if (validateForms() == false) return false;

    final task = TaskEntity(
      id: taskId,
      task: taskTitle.value,
      xp: 5,
      status: status.value,
      createdAt: DateTime.now(),
    );

    await newTask.execute(
      () => pageIsForEditing ? _updateTaskUseCase(task) : _createTaskUseCase(task),
    );

    if (hasFailure) return false;

    Modular.to.pop(true);

    return true;
  }
}
