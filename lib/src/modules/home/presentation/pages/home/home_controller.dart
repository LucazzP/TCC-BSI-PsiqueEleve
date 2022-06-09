import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_active_user_role.usecase.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/set_active_user_role.usecase.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
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
    'Consultas',
    'Tarefas',
    'Menu',
  ];

  final activePage = ValueStore(0);
  final user = ValueState<UserEntity?>(null);
  final selectedUserRole = ValueState<UserType?>(null);

  void initialize() {
    final index = max(0, _screenRoutes.indexOf(Modular.to.navigateHistory.first.name));
    onTapChangePage(index);
    getUserLogged();
    getActiveUserRole();
  }

  @computed
  bool get shouldShowDropdownUserRole => selectedUserRole.value != null && userRoles.length > 1;

  @computed
  String get titlePage => getNavBarItems[activePage.value].label ?? _titles[activePage.value];

  @computed
  List<UserType> get userRoles {
    final _user = user.value;
    if (_user == null) return [];
    if (_user.role.type == UserType.admin) {
      return UserType.values;
    }
    return _user.roles.map((e) => e.type).toList();
  }

  @computed
  List<BottomNavigationBarItem> get getNavBarItems {
    final items = [
      BottomNavigationBarItem(icon: const Icon(Icons.home_rounded), label: _titles[0]),
      BottomNavigationBarItem(icon: const Icon(Icons.calendar_today_rounded), label: _titles[1]),
      BottomNavigationBarItem(icon: const Icon(Icons.task_alt_rounded), label: _titles[2]),
      BottomNavigationBarItem(icon: const Icon(Icons.menu_rounded), label: _titles[3]),
    ];
    final role = selectedUserRole.value;
    if (role == null) return items;
    switch (role) {
      case UserType.admin:
        items.removeRange(0, 3);
        break;
      case UserType.therapist:
        items.removeAt(2);
        break;
      case UserType.patient:
      case UserType.responsible:
        break;
    }
    return items;
  }

  @override
  Iterable<ValueState> get getStates => [user, selectedUserRole];

  void onTapChangePage(int index) {
    activePage.setValue(index);
    final label = getNavBarItems[index].label ?? '';
    final routeIndex = _titles.indexOf(label);
    if (routeIndex == -1) return;
    Modular.to.navigate(_screenRoutes[routeIndex]);
  }

  Future<void> getUserLogged() async {
    return user.execute(_getUserLoggedUseCase);
  }

  Future<void> getActiveUserRole() async {
    final selectedRole = await _getActiveUserRoleUseCase();
    selectedUserRole.setValue(selectedRole.type);
    final index = max(0, _screenRoutes.indexOf(Modular.to.navigateHistory.first.name));
    onTapChangePage(index);
  }

  void onChangedUserRole(UserType? userType) {
    if (userType == null) return;
    _setActiveUserRoleUseCase.call(userType);
    selectedUserRole.setValue(userType);
    Modular.to.navigate(kSplashScreenRoute);
  }
}
