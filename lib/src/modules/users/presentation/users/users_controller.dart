import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/extensions/iterable.ext.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/users/domain/usecases/get_patients.usecase.dart';
import 'package:psique_eleve/src/modules/users/domain/usecases/get_therapists.usecase.dart';
import 'package:psique_eleve/src/modules/users/domain/usecases/get_user.usecase.dart';
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
  final GetUserUseCase _getUserUseCase;

  _UsersControllerBase(this._getTherapistsUseCase, this._getPatientsUseCase, this._getUserUseCase);

  final users = ValueState<List<UserEntity>>([]);
  final title = ValueStore('');
  final emptyMessage = ValueStore('');
  final selectedUsers = ValueState<Set<UserEntity>>({});

  @override
  Iterable<ValueState> get getStates => [users, selectedUsers];

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

  Future<void> addEditUser([UserEntity? user]) async {
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

  void onTapTile(UserEntity user, bool isInSelectMode, bool isMultiSelect) {
    if (isInSelectMode) {
      _selectUser(user);
      if (!isMultiSelect) {
        onTapFinishSelection();
      }
      return;
    }
    addEditUser(user);
  }

  void _selectUser(UserEntity user) {
    if (selectedUsers.value.contains(user)) {
      selectedUsers.setValue(selectedUsers.value.toSet()..remove(user));
    } else {
      selectedUsers.setValue(selectedUsers.value.toSet()..add(user));
    }
    selectedUsers.execute(
      () async {
        final res = await _getUserUseCase.call(user.id);
        return res.map((updatedUser) =>
            selectedUsers.value.map((e) => e.id == updatedUser.id ? updatedUser : e).toSet());
      },
      shouldSetToInitialValue: false,
      shouldSetLoading: false,
    );
  }

  Future<void> onTapFinishSelection() async {
    selectedUsers.setLoading(true);
    await selectedUsers.executeFuture;
    Modular.to.pop(selectedUsers.value.map((e) => e.therapistRelationship).whereNotNull().toList());
  }
}
