import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/reset_password.usecase.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/form.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:psique_eleve/src/presentation/constants/validators.dart';

part 'reset_password_controller.g.dart';

class ResetPasswordController = _ResetPasswordControllerBase with _$ResetPasswordController;

abstract class _ResetPasswordControllerBase extends BaseStore with Store {
  final ResetPasswordUseCase _resetPasswordUseCase;
  _ResetPasswordControllerBase(this._resetPasswordUseCase);

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
