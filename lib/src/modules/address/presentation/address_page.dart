import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/helpers/ui_helper.dart';
import 'package:psique_eleve/src/presentation/routes.dart';
import 'package:psique_eleve/src/presentation/widgets/app_button/app_button.dart';
import 'package:psique_eleve/src/presentation/widgets/app_text_field/app_text_field_widget.dart';

import 'address_controller.dart';

class AddressPage extends StatefulWidget {
  static Future<void> navigateTo() => Modular.to.pushNamed(kTherapistAddScreenRoute);

  const AddressPage({Key? key}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends BaseState<AddressPage, AddressController> {
  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => AppBar(
        title: const Text('Adicionar terapeuta'),
      );

  @override
  Widget child(context, constrains) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'Nome completo',
            // onChanged: controller.onEmailChanged,
            // errorText: controller.email.value.error,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
          );
        }),
        UIHelper.verticalSpaceS12,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'Email',
            // onChanged: controller.onPasswordChanged,
            // errorText: controller.password.value.error,
            obscureText: true,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
          );
        }),
        UIHelper.verticalSpaceS12,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'CPF',
            // onChanged: controller.onPasswordChanged,
            // errorText: controller.password.value.error,
            obscureText: true,
            textInputAction: TextInputAction.next,
          );
        }),
        UIHelper.verticalSpaceS12,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'Telefone',
            // onChanged: controller.onPasswordChanged,
            // errorText: controller.password.value.error,
            obscureText: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => controller.onTapCreateEdit(),
          );
        }),
        UIHelper.verticalSpaceS32,
        AppButton(
          onPressed: controller.onTapCreateEdit,
          title: 'Entrar',
          style: AppButtonStyle.filled,
        ),
        UIHelper.verticalSpaceS32,
      ],
    );
  }
}
