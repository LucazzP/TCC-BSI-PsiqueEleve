import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/login_email_usecase.dart';
import 'package:psique_eleve/src/modules/home/presentation/pages/home/home_page.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/presentation/models/form_model.dart';
import 'package:psique_eleve/src/presentation/validators.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase extends BaseStore with Store {
  final LoginEmailUseCase _loginUseCase;

  _LoginControllerBase(this._loginUseCase);

  final email = ValueStore<FormModel>(const FormModel(validator: Validators.email));
  final password = ValueStore<FormModel>(const FormModel(validator: Validators.password));

  final userState = ValueState<UserEntity?>(null);

  @override
  Iterable<ValueState> get getStates => [userState];

  @override
  List<ValueStore<FormModel>> get getForms => [email, password];

  void onTapLogin() async {
    if (validateForms() == false) return;
    await userState.execute(
      () => _loginUseCase.call(LoginEmailParams(
        email: email.value.value,
        password: password.value.value,
      )),
    );
    if (userState.value != null) {
      HomePage.replaceTo();
    }
  }

  void onEmailChanged(String value) => email.setValue(email.value.copyWith(value: value));
  void onPasswordChanged(String value) => password.setValue(password.value.copyWith(value: value));
}
