import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/helpers/ui_helper.dart';
import 'package:psique_eleve/src/presentation/images.dart';
import 'package:psique_eleve/src/presentation/routes.dart';
import 'package:psique_eleve/src/presentation/styles/app_color_scheme.dart';
import 'package:psique_eleve/src/presentation/styles/app_text_theme.dart';
import 'package:psique_eleve/src/presentation/widgets/app_button/app_button.dart';
import 'package:psique_eleve/src/presentation/widgets/app_text_field/app_text_field_widget.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  static Future<void> navigateTo() => Modular.to.pushNamed(kAuthLoginScreenRoute);
  static Future<void> replaceTo() => Modular.to.pushReplacementNamed(kAuthLoginScreenRoute);

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginController> {
  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => null;

  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  bool supportScrolling(BuildContext context) => false;

  @override
  Widget child(context, constrains) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: AppColorScheme.primaryLight,
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: const Divider(
              height: 1,
              thickness: 2,
              color: AppColorScheme.primaryDefault,
            ),
            titlePadding: EdgeInsets.zero,
            expandedTitleScale: 1,
            background: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(kLogoPsiqueEleveBig),
                  Text(
                    'Entre ou cadastre-se na plataforma',
                    style: AppTextTheme.textTheme.caption,
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(24),
          sliver: SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Observer(builder: (_) {
                  return AppTextFieldWidget(
                    title: 'Email',
                    onChanged: controller.email.setValue,
                    errorText: controller.email.error,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                  );
                }),
                UIHelper.verticalSpaceS12,
                Observer(builder: (_) {
                  return AppTextFieldWidget(
                    title: 'Senha',
                    onChanged: controller.password.setValue,
                    errorText: controller.password.error,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => controller.onTapLogin(),
                  );
                }),
                UIHelper.verticalSpaceS32,
                AppButton(
                  onPressed: controller.onTapLogin,
                  title: 'Entrar',
                  style: AppButtonStyle.filled,
                ),
                UIHelper.verticalSpaceS32,
                Text.rich(
                  TextSpan(
                    text: 'Esqueceu sua senha? ',
                    style: AppTextTheme.textTheme.caption,
                    children: [
                      TextSpan(
                        text: 'Clique aqui',
                        style: AppTextTheme.textTheme.caption
                            ?.copyWith(decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Modular.to.pushNamed(kAuthLoginScreenRoute),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
