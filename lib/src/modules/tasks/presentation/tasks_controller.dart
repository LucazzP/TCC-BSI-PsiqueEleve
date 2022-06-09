import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/modules/appointment/domain/constants/status.enum.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/role_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_active_user_role.usecase.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:psique_eleve/src/modules/tasks/domain/entity/task.entity.dart';
import 'package:psique_eleve/src/modules/tasks/domain/usecases/get_tasks.usecase.dart';
import 'package:psique_eleve/src/modules/tasks/domain/usecases/update_task.usecase.dart';
import 'package:psique_eleve/src/modules/tasks/presentation/add_edit_task/add_edit_task_page.dart';
import 'package:psique_eleve/src/modules/users/domain/entities/therapist_patient_relationship.entity.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';

part 'tasks_controller.g.dart';

class TasksController = _TasksControllerBase with _$TasksController;

abstract class _TasksControllerBase extends BaseStore with Store {
  final GetTasksUseCase _getTasksUseCase;
  final GetUserLoggedUseCase _getUserLoggedUseCase;
  final GetActiveUserRoleUseCase _getActiveUserRoleUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;

  _TasksControllerBase(
    this._getTasksUseCase,
    this._getUserLoggedUseCase,
    this._getActiveUserRoleUseCase,
    this._updateTaskUseCase,
  );

  final tasks = ValueState<List<TaskEntity>>([]);
  final therapistPatientRelationship = ValueState<TherapistPatientRelationshipEntity?>(null);
  final selectedUserRole = ValueState<RoleEntity?>(null);

  @override
  Iterable<ValueState> get getStates => [tasks, therapistPatientRelationship, selectedUserRole];

  @computed
  bool get shouldShowCreateButton => selectedUserRole.value?.canManageAppointments == true;

  Future<void> initialize(TherapistPatientRelationshipEntity? therapistPatient) async {
    getActiveUserRole().ignore();
    if (therapistPatient != null) {
      therapistPatientRelationship.setValue(therapistPatient);
    } else {
      await getUserTherapistPatientRelationship();
    }
    return getTasks();
  }

  Future<void> getActiveUserRole() => selectedUserRole.execute(_getActiveUserRoleUseCase.asEither);

  Future<void> getTasks() async =>
      tasks.execute(() => _getTasksUseCase.call(therapistPatientRelationship.value?.id ?? ''));

  Future<void> getUserTherapistPatientRelationship() =>
      therapistPatientRelationship.execute(() => _getUserLoggedUseCase().then((value) {
            return value.map((r) => r?.therapistRelationship);
          }));

  Future<void> onTapAddEditTask([TaskEntity? task]) async {
    if (selectedUserRole.value?.canManageTasks == false) {
      if (task != null) onTapCheckbox(task);
      return;
    }
    final _therapistPatientRelationship = therapistPatientRelationship.value;
    if (_therapistPatientRelationship == null) return;

    final editted = await AddEditTaskPage.navigateTo(task, _therapistPatientRelationship);
    if (editted == true) return getTasks();
  }

  Future<void> onTapCheckbox(TaskEntity task) async {
    Status status;

    if (isTaskChecked(task)) {
      status = Status.todo;
    } else {
      if (task.date.isAfter(DateTime.now())) {
        status = Status.completed;
      } else {
        status = Status.completedOverdue;
      }
    }

    tasks.setValue(
      tasks.value.map((t) => t.id == task.id ? task.copyWith(status: status) : t).toList(),
    );

    final res = await _updateTaskUseCase.call(task.copyWith(status: status));
    res.fold((error) {
      tasks.setValue(tasks.value
          .map((t) => t.id == task.id ? task.copyWith(status: task.status) : t)
          .toList());
      tasks.setFailure(error);
    }, (r) => null);
  }

  bool isTaskChecked(TaskEntity task) =>
      [Status.completed, Status.completedOverdue].contains(task.status);
}
