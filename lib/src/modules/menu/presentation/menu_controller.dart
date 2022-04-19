import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/role_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:psique_eleve/src/modules/menu/model/menu_option_model.dart';
import 'package:psique_eleve/src/modules/users/presentation/add_edit_user/add_edit_user_page.dart';
import 'package:psique_eleve/src/modules/users/presentation/users/users_page.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:mobx/mobx.dart';

part 'menu_controller.g.dart';

class MenuController = _MenuControllerBase with _$MenuController;

abstract class _MenuControllerBase extends BaseStore with Store {
  final GetUserLoggedUseCase _getUserLoggedUseCase;

  _MenuControllerBase(this._getUserLoggedUseCase);

  final user = ValueState<UserEntity?>(null);
  final options = ValueStore<List<MenuOptionModel>>([]);

  @override
  Iterable<ValueState> get getStates => [user];

  Future<void> getUserLogged() async {
    await user.execute(() => _getUserLoggedUseCase.call());
    _setOptions();
  }

  void _setOptions() {
    final _user = user.value;
    final _role = _user?.role ?? const RoleEntity();
    options.setValue([
      MenuOptionModel(
        title: 'Perfil',
        onTap: () {
          if (_user != null) {
            AddEditUserPage.navigateToEdit(_user, true);
          } else {
            Modular.to.pop();
          }
        },
      ),
      if (_role.canManageTherapists)
        MenuOptionModel(
          title: 'Gerenciar Terapeutas',
          onTap: () => UsersPage.navigateTo(UserType.therapist),
        ),
      if (_role.canManagePatients)
        MenuOptionModel(
          title: 'Gerenciar Pacientes',
          onTap: () => UsersPage.navigateTo(UserType.patient),
        ),
      MenuOptionModel(title: 'Configurações', onTap: () {}),
    ]);
  }
}
