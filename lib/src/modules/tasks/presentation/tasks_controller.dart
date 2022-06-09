import 'package:psique_eleve/src/modules/tasks/domain/entity/task.entity.dart';
import 'package:psique_eleve/src/modules/tasks/domain/usecases/get_tasks.usecase.dart';
import 'package:psique_eleve/src/modules/tasks/presentation/add_edit_task/add_edit_task_page.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:mobx/mobx.dart';

part 'tasks_controller.g.dart';

class TasksController = _TasksControllerBase with _$TasksController;

abstract class _TasksControllerBase extends BaseStore with Store {
  final GetTasksUseCase _getTasksUseCase;

  _TasksControllerBase(this._getTasksUseCase);

  final tasks = ValueState<List<TaskEntity>>([]);

  @override
  Iterable<ValueState> get getStates => [tasks];

  void getTasks() async {
    return tasks.execute(_getTasksUseCase);
  }

  Future<void> onTapAddEditTask([TaskEntity? task]) async {
    final editted = await AddEditTaskPage.navigateTo(task);
    if (editted == true) return getTasks();
  }
}
