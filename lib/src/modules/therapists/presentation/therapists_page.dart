import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/routes.dart';

import 'therapists_controller.dart';

class TherapistsPage extends StatefulWidget {
  static Future<void> navigateTo() => Modular.to.pushNamed(kTherapistsScreenRoute);

  const TherapistsPage({Key? key}) : super(key: key);

  @override
  _TherapistsPageState createState() => _TherapistsPageState();
}

class _TherapistsPageState extends BaseState<TherapistsPage, TherapistsController> {
  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => AppBar(
        title: const Text('Terapeutas'),
      );

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
