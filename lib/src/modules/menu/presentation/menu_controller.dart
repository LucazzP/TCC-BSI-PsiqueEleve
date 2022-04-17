import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:mobx/mobx.dart';

part 'menu_controller.g.dart';

class MenuController = _MenuControllerBase with _$MenuController;

abstract class _MenuControllerBase extends BaseStore with Store {
  final GetUserLoggedUseCase _getUserLoggedUseCase;

  _MenuControllerBase(this._getUserLoggedUseCase);

  final user = ValueState<UserEntity?>(null);

  @override
  Iterable<ValueState> get getStates => [user];

  Future<void> getUserLogged() {
    return user.execute(() => _getUserLoggedUseCase.call());
  }
}
