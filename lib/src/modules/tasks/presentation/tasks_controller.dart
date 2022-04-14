import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:mobx/mobx.dart';

part 'tasks_controller.g.dart';

class TasksController = _TasksControllerBase with _$TasksController;

abstract class _TasksControllerBase extends BaseStore with Store {
  final counter = ValueState(0);

  @override
  Iterable<ValueState> get getStates => [counter];
}
