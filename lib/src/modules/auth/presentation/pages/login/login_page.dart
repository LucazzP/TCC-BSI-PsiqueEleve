import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/routes.dart';

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
  PreferredSizeWidget appBar(BuildContext ctx) => AppBar();

  @override
  Widget child(context, constrains) {
    return Column(
      children: [
        Observer(builder: (_) {
          return Text(controller.counter.value.toString());
        }),
        TextButton(
          onPressed: () {
            controller.counter.setValue(controller.counter.value + 1);
          },
          child: const Text('login'),
        )
      ],
    );
  }
}
