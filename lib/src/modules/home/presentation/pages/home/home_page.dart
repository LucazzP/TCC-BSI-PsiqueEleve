import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/routes.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  static Future<void> navigateTo() => Modular.to.pushNamed(kHomeScreenRoute);
  static Future<void> replaceTo() => Modular.to.pushReplacementNamed(kHomeScreenRoute);

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
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
          child: const Text('aumentar'),
        )
      ],
    );
  }
}
