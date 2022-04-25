import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/users/domain/usecases/get_patients.usecase.dart';
import 'package:psique_eleve/src/modules/users/domain/usecases/get_therapists.usecase.dart';
import 'package:psique_eleve/src/modules/users/presentation/add_edit_user/add_edit_user_page.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';

part 'users_controller.g.dart';

class UsersController = _UsersControllerBase with _$UsersController;

abstract class _UsersControllerBase extends BaseStore with Store {
  final GetTherapistsUseCase _getTherapistsUseCase;
  final GetPatientsUseCase _getPatientsUseCase;
  late final UserType userType;

  _UsersControllerBase(this._getTherapistsUseCase, this._getPatientsUseCase);

  final users = ValueState<List<UserEntity>>([]);
  final title = ValueStore('');
  final emptyMessage = ValueStore('');

  @override
  Iterable<ValueState> get getStates => [users];

  void initialize(UserType userType) {
    this.userType = userType;
    _setStrings();
  }

  Future<void> getUsers([int page = 0]) {
    switch (userType) {
      case UserType.admin:
      case UserType.therapist:
        return users.execute(() => _getTherapistsUseCase.call(page));
      case UserType.patient:
      case UserType.responsible:
        return users.execute(() => _getPatientsUseCase.call(page));
    }
  }

  Future<void> onTapAddEditUser([UserEntity? user]) async {
    bool shouldUpdate = false;
    if (user == null) {
      shouldUpdate = await AddEditUserPage.navigateToAdd(userType) ?? false;
    } else {
      shouldUpdate = await AddEditUserPage.navigateToEdit(user, false, userType: userType) ?? false;
    }
    if (shouldUpdate == true) getUsers();
  }

  void _setStrings() {
    switch (userType) {
      case UserType.admin:
      case UserType.therapist:
        title.setValue('Terapeutas');
        return emptyMessage.setValue('Nenhum terapeuta cadastrado');
      case UserType.patient:
      case UserType.responsible:
        title.setValue('Pacientes');
        return emptyMessage.setValue('Nenhum paciente cadastrado');
    }
  }
}
