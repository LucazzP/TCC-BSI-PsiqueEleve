import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/change_password.usecase.dart';
import 'package:psique_eleve/src/modules/home/presentation/pages/feed/feed_page.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/form.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:psique_eleve/src/presentation/constants/validators.dart';

part 'reset_password_controller.g.dart';

class ResetPasswordController = _ResetPasswordControllerBase with _$ResetPasswordController;

abstract class _ResetPasswordControllerBase extends BaseStore with Store {
  final ChangePasswordUseCase _changePasswordUseCase;

  final password = FormStore(Validators.password);
  late final FormStore confirmPassword;
  final resetPassState = ValueState<Unit>(unit);

  _ResetPasswordControllerBase(this._changePasswordUseCase) {
    confirmPassword =
        FormStore((confirmPass) => Validators.confirmPassword(password.value, confirmPass));
  }

  @override
  Iterable<ValueState> get getStates => [resetPassState];
  
  @override
  List<FormStore> get getForms => [password, confirmPassword];

  Future<bool> onTapChangePass() async {
    if (validateForms() == false) return false;
    await resetPassState.execute(() => _changePasswordUseCase(password.value));
    final success = hasFailure == false;
    if (success) FeedPage.replaceTo();
    return success;
  }
}
