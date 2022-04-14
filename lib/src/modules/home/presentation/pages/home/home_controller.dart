import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/presentation/routes.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase extends BaseStore with Store {
  final screenRoutes = [
    kHomeFeedScreenRoute,
    kHomeAppointmentsScreenRoute,
    kHomeTasksScreenRoute,
    kHomeMenuScreenRoute,
  ];

  final activePage = ValueStore(0);

  @override
  Iterable<ValueState> get getStates => [];

  void onTapChangePage(int index) {
    activePage.setValue(index);
    Modular.to.navigate(screenRoutes[index]);
  }
}
