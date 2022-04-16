import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/login_email_usecase.dart';
import 'package:psique_eleve/src/modules/home/presentation/pages/feed/feed_page.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/form.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:psique_eleve/src/presentation/validators.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase extends BaseStore with Store {
  final LoginEmailUseCase _loginUseCase;

  _LoginControllerBase(this._loginUseCase);

  final email = FormStore(Validators.email);
  final password = FormStore(Validators.password);

  final userState = ValueState<UserEntity?>(null);

  @override
  Iterable<ValueState> get getStates => [userState];

  @override
  List<FormStore> get getForms => [email, password];

  void onTapLogin() async {
    if (validateForms() == false) return;
    await userState.execute(
      () => _loginUseCase.call(LoginEmailParams(
        email: email.value,
        password: password.value,
      )),
    );
    if (userState.value != null) {
      FeedPage.replaceTo();
    }
  }
}
