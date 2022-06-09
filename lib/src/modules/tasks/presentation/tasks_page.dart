import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';
import 'package:psique_eleve/src/presentation/styles/app_color_scheme.dart';
import 'package:psique_eleve/src/presentation/styles/app_spacing.dart';

import 'tasks_controller.dart';

class TasksPage extends StatefulWidget {
  static Future<void> navigateTo() => Modular.to.pushNamed(kHomeTasksScreenRoute);
  static Future<void> navigateToNewPage() => Modular.to.pushNamed(kTasksScreenRoute);

  static Future<void> replaceTo() => Modular.to.pushReplacementNamed(kHomeTasksScreenRoute);

  const TasksPage({Key? key}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends BaseState<TasksPage, TasksController> {
  @override
  void initState() {
    controller.getTasks();
    super.initState();
  }

  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => null;

  @override
  Widget? get floatingActionButton => FloatingActionButton(
        onPressed: controller.onTapAddEditTask,
        backgroundColor: AppColorScheme.primaryButtonBackground,
        child: const Icon(Icons.add, color: Colors.white),
      );

  @override
  Widget child(context, constrains) {
    return Observer(builder: (context) {
      final tasks = controller.tasks.value;
      if (tasks.isEmpty && !controller.isLoading) {
        return const Center(
          child: Text('Não há nenhuma task criada.'),
        );
      }
      return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.task),
            onTap: () => controller.onTapAddEditTask(task),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s24,
              vertical: AppSpacing.s4,
            ),
          );
        },
      );
    });
  }
}
