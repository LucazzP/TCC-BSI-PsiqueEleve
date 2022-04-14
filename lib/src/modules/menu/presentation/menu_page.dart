import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/routes.dart';

import 'menu_controller.dart';

class MenuPage extends StatefulWidget {
  static Future<void> navigateTo() => Modular.to.pushNamed(kHomeMenuScreenRoute);
  static Future<void> replaceTo() => Modular.to.pushReplacementNamed(kHomeMenuScreenRoute);

  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends BaseState<MenuPage, MenuController> {
  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => null;

  @override
  Widget child(context, constrains) {
    return Column(
      children: [
        const Text('Menu'),
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
