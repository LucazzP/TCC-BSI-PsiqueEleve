import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/role_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_active_user_role.usecase.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/logout.usecase.dart';
import 'package:psique_eleve/src/modules/auth/presentation/pages/reset_password/reset_password_page.dart';
import 'package:psique_eleve/src/modules/menu/model/menu_option_model.dart';
import 'package:psique_eleve/src/modules/users/presentation/add_edit_user/add_edit_user_page.dart';
import 'package:psique_eleve/src/modules/users/presentation/users/users_page.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';

part 'menu_controller.g.dart';

class MenuController = _MenuControllerBase with _$MenuController;

abstract class _MenuControllerBase extends BaseStore with Store {
  final GetUserLoggedUseCase _getUserLoggedUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetActiveUserRoleUseCase _getActiveUserRoleUseCase;

  _MenuControllerBase(
    this._getUserLoggedUseCase,
    this._logoutUseCase,
    this._getActiveUserRoleUseCase,
  );

  final user = ValueState<UserEntity?>(null);
  RoleEntity role = const RoleEntity();
  final options = ValueStore<List<MenuOptionModel>>([]);

  @override
  Iterable<ValueState> get getStates => [user];

  Future<void> getUserLogged([bool refreshed = false]) async {
    await Future.wait([
      user.execute(() => _getUserLoggedUseCase.call(refreshed)),
      _getActiveUserRoleUseCase().then((value) => role = value),
    ]);
    _setOptions();
  }

  Future<void> _logout() async {
    await user.execute(() => _logoutUseCase.call().then((value) => value.map((r) => null)));
    if (hasFailure) return;
    Modular.to.navigate(kAuthLoginScreenRoute);
  }

  void _setOptions() {
    final _user = user.value;
    options.setValue([
      MenuOptionModel(
        title: 'Perfil',
        icon: Icons.person,
        onTap: () async {
          if (_user != null) {
            final wasModified = await AddEditUserPage.navigateToEdit(_user, true);
            if (wasModified == true) getUserLogged(true);
          } else {
            Modular.to.pop();
          }
        },
      ),
      if (role.canManageTherapists)
        MenuOptionModel(
          title: 'Gerenciar Terapeutas',
          icon: Icons.people,
          onTap: () => UsersPage.navigateTo(UserType.therapist),
        ),
      if (role.canManagePatients)
        MenuOptionModel(
          title: 'Gerenciar Pacientes',
          icon: Icons.people,
          onTap: () => UsersPage.navigateTo(UserType.patient),
        ),
      MenuOptionModel(
        title: 'Alterar a senha',
        icon: Icons.lock,
        onTap: () => ResetPasswordPage.navigateTo(),
      ),
      MenuOptionModel(
        title: 'Sair da conta',
        icon: Icons.logout,
        onTap: _logout,
      ),
    ]);
  }
}
