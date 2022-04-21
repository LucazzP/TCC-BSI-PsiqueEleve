import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/core/constants.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';
import 'package:psique_eleve/src/presentation/helpers/ui_helper.dart';
import 'package:psique_eleve/src/presentation/widgets/app_button/app_button.dart';
import 'package:psique_eleve/src/presentation/widgets/app_snackbar/app_snackbar.dart';
import 'package:psique_eleve/src/presentation/widgets/app_text_field/app_text_field_widget.dart';

import 'reset_password_controller.dart';

class ResetPasswordPage extends StatefulWidget {
  static Future<void> navigateTo() => Modular.to.pushNamed(kAuthResetPasswordScreenRoute);

  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends BaseState<ResetPasswordPage, ResetPasswordController> {
  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => AppBar(
        title: const Text("Alterar senha"),
      );

  @override
  Widget child(context, constrains) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UIHelper.verticalSpaceS16,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'Nova senha',
            controller: controller.password.controller,
            errorText: controller.password.error,
            obscureText: true,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.newPassword],
          );
        }),
        UIHelper.verticalSpaceS12,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'Confirme a nova senha',
            controller: controller.confirmPassword.controller,
            errorText: controller.confirmPassword.error,
            obscureText: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => changePass(),
            autofillHints: const [AutofillHints.newPassword],
          );
        }),
        UIHelper.verticalSpaceS40,
        AppButton(
          onPressed: changePass,
          title: 'Alterar',
          style: AppButtonStyle.filled,
        ),
      ],
    );
  }

  void changePass() async {
    final success = await controller.onTapChangePass();
    if (success) {
      await Future.delayed(k100msDuration);
      AppSnackBar.success(context, 'Senha alterada com sucesso!');
    }
  }
}
