import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/core/constants.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';
import 'package:psique_eleve/src/presentation/helpers/ui_helper.dart';
import 'package:psique_eleve/src/presentation/styles/app_color_scheme.dart';
import 'package:psique_eleve/src/presentation/styles/app_text_theme.dart';
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
        title: const Text("Esqueci minha senha"),
      );

  @override
  Widget child(context, constrains) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UIHelper.verticalSpaceS16,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'Email',
            controller: controller.email.controller,
            errorText: controller.email.error,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
          );
        }),
        UIHelper.verticalSpaceS40,
        AppButton(
          onPressed: () async {
            final success = await controller.onTapResetPass();
            if (success) {
              await Future.delayed(k100msDuration);
              AppSnackBar.success(context, 'Email enviado com sucesso!');
            }
          },
          title: 'Enviar',
          style: AppButtonStyle.filled,
        ),
      ],
    );
  }
}
