import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/login_email_usecase.dart';
import 'package:psique_eleve/src/modules/home/presentation/pages/feed/feed_page.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/form.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:psique_eleve/src/presentation/constants/validators.dart';

part 'reset_password_controller.g.dart';

class ResetPasswordController = _ResetPasswordControllerBase with _$ResetPasswordController;

abstract class _ResetPasswordControllerBase extends BaseStore with Store {
  final email = FormStore(Validators.email);
  final password = FormStore(Validators.password);

  final userState = ValueState<UserEntity?>(null);

  @override
  Iterable<ValueState> get getStates => [userState];

  @override
  List<FormStore> get getForms => [email, password];

  void onTapLogin() async {
    if (validateForms() == false) return;
    if (userState.value != null) {
      FeedPage.replaceTo();
    }
  }
}
