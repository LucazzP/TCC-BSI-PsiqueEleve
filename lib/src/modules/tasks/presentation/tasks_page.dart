import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';

import 'tasks_controller.dart';

class TasksPage extends StatefulWidget {
  static Future<void> navigateTo() => Modular.to.pushNamed(kHomeTasksScreenRoute);
  static Future<void> replaceTo() => Modular.to.pushReplacementNamed(kHomeTasksScreenRoute);

  const TasksPage({Key? key}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends BaseState<TasksPage, TasksController> {
  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => null;

  @override
  Widget child(context, constrains) {
    return Column(
      children: [
        const Text('Tasks'),
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
