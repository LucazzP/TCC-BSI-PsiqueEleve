import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/recover_password.usecase.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/form.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:psique_eleve/src/presentation/constants/validators.dart';

part 'recover_password_controller.g.dart';

class RecoverPasswordController = _RecoverPasswordControllerBase with _$RecoverPasswordController;

abstract class _RecoverPasswordControllerBase extends BaseStore with Store {
  final RecoverPasswordUseCase _resetPasswordUseCase;
  _RecoverPasswordControllerBase(this._resetPasswordUseCase);

  final email = FormStore(Validators.email);

  final resetPassState = ValueState<Unit>(unit);

  @override
  Iterable<ValueState> get getStates => [resetPassState];

  @override
  List<FormStore> get getForms => [email];

  Future<bool> onTapResetPass() async {
    if (validateForms() == false) return false;
    await resetPassState.execute(() => _resetPasswordUseCase(email.value));
    if (hasFailure == false) {
      Modular.to.pop();
      return true;
    }
    return false;
  }
}
