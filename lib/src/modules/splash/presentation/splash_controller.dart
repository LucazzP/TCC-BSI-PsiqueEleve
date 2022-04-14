import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:psique_eleve/src/modules/auth/presentation/pages/login/login_page.dart';
import 'package:psique_eleve/src/modules/home/presentation/pages/home/home_page.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:mobx/mobx.dart';

part 'splash_controller.g.dart';

class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase extends BaseStore with Store {
  final GetUserLoggedUseCase _getUserLoggedUseCase;

  _SplashControllerBase(this._getUserLoggedUseCase);

  final ValueState<UserEntity?> userLogged = ValueState(null);

  @override
  Iterable<ValueState> get getStates => [userLogged];

  Future<void> onInit(Future initializeLocalization) async {
    // await userLogged.execute(_getUserLoggedUseCase);
    await initializeLocalization;

    if (userLogged.value != null) {
      return navigateToHome();
    }
    return navigateToLogin();
  }

  Future<void> navigateToHome() => HomePage.replaceTo();
  Future<void> navigateToLogin() => LoginPage.replaceTo();
}
