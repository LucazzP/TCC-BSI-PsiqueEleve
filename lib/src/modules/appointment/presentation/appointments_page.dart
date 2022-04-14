import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/routes.dart';

import 'appointments_controller.dart';

class AppointmentsPage extends StatefulWidget {
  static Future<void> navigateTo() => Modular.to.pushNamed(kHomeAppointmentsScreenRoute);
  static Future<void> replaceTo() => Modular.to.pushReplacementNamed(kHomeAppointmentsScreenRoute);

  const AppointmentsPage({Key? key}) : super(key: key);

  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends BaseState<AppointmentsPage, AppointmentsController> {
  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => null;

  @override
  Widget child(context, constrains) {
    return Column(
      children: [
        const Text('Appointments'),
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
