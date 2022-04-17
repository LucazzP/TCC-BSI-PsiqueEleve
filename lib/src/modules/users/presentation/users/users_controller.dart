import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/users/domain/usecases/get_therapists.usecase.dart';
import 'package:psique_eleve/src/modules/users/presentation/add_edit_user/add_edit_user_page.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';

part 'users_controller.g.dart';

class UsersController = _UsersControllerBase with _$UsersController;

abstract class _UsersControllerBase extends BaseStore with Store {
  final GetUsersUseCase _getUsersUseCase;
  late final UserType userType;

  _UsersControllerBase(this._getUsersUseCase);

  final users = ValueState<List<UserEntity>>([]);

  @override
  Iterable<ValueState> get getStates => [users];

  Future<void> getUsers([int page = 0]) {
    return users.execute(() => _getUsersUseCase.call(page));
  }

  void initialize(UserType userType) {
    this.userType = userType;
  }

  void onTapAddUser() {
    AddEditUserPage.navigateToAdd(userType);
  }
}
