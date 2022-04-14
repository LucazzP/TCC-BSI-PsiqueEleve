import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:mobx/mobx.dart';

part 'menu_controller.g.dart';

class MenuController = _MenuControllerBase with _$MenuController;

abstract class _MenuControllerBase extends BaseStore with Store {
  final counter = ValueState(0);

  @override
  Iterable<ValueState> get getStates => [counter];
}
