import 'dart:math';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_active_user_role.usecase.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/set_active_user_role.usecase.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase extends BaseStore with Store {
  final GetUserLoggedUseCase _getUserLoggedUseCase;
  final GetActiveUserRoleUseCase _getActiveUserRoleUseCase;
  final SetActiveUserRoleUseCase _setActiveUserRoleUseCase;

  _HomeControllerBase(
    this._getUserLoggedUseCase,
    this._getActiveUserRoleUseCase,
    this._setActiveUserRoleUseCase,
  );

  static const _screenRoutes = [
    kHomeFeedScreenRoute,
    kHomeAppointmentsScreenRoute,
    kHomeTasksScreenRoute,
    kHomeMenuScreenRoute,
  ];

  static const _titles = [
    'Home',
    'Agendamentos',
    'Tarefas',
    'Menu',
  ];

  final activePage = ValueStore(0);
  final user = ValueState<UserEntity?>(null);
  final selectedUserRole = ValueState<UserType?>(null);

  void initialize() {
    final index = max(0, _screenRoutes.indexOf(Modular.to.navigateHistory.first.name));
    activePage.setValue(index);
    getUserLogged();
    getUserLogged();
    getActiveUserRole();
  }

  @computed
  bool get shouldShowDropdownUserRole => selectedUserRole.value != null && userRoles.isNotEmpty;

  @computed
  String get titlePage => _titles[activePage.value];

  @computed
  List<UserType> get userRoles {
    final _user = user.value;
    if (_user == null) return [];
    if (_user.role.type == UserType.admin) {
      return UserType.values;
    }
    return _user.roles.map((e) => e.type).toList();
  }

  @override
  Iterable<ValueState> get getStates => [user];

  void onTapChangePage(int index) {
    activePage.setValue(index);
    Modular.to.navigate(_screenRoutes[index]);
  }

  Future<void> getUserLogged() async {
    return user.execute(_getUserLoggedUseCase);
  }

  Future<void> getActiveUserRole() async {
    final selectedRole = await _getActiveUserRoleUseCase();
    return selectedUserRole.setValue(selectedRole);
  }

  void onChangedUserRole(UserType? userType) {
    if (userType == null) return;
    _setActiveUserRoleUseCase.call(userType);
    selectedUserRole.setValue(userType);
  }
}
