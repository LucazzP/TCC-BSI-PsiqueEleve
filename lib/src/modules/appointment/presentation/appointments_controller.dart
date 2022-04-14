import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:mobx/mobx.dart';

part 'appointments_controller.g.dart';

class AppointmentsController = _AppointmentsControllerBase with _$AppointmentsController;

abstract class _AppointmentsControllerBase extends BaseStore with Store {
  final counter = ValueState(0);

  @override
  Iterable<ValueState> get getStates => [counter];
}
