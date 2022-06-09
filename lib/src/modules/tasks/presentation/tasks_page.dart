import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/extensions/date_time.ext.dart';
import 'package:psique_eleve/src/modules/appointment/domain/constants/status.enum.dart';
import 'package:psique_eleve/src/modules/users/domain/entities/therapist_patient_relationship.entity.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';
import 'package:psique_eleve/src/presentation/styles/app_color_scheme.dart';
import 'package:psique_eleve/src/presentation/styles/app_spacing.dart';

import 'tasks_controller.dart';

class TasksPage extends StatefulWidget {
  final TherapistPatientRelationshipEntity? therapistPatientRelationship;
  static Future<void> navigateTo() => Modular.to.pushNamed(kHomeTasksScreenRoute);
  static Future<void> navigateToNewPage(
          TherapistPatientRelationshipEntity therapistPatientRelationship) =>
      Modular.to.pushNamed(kTasksScreenRoute, arguments: therapistPatientRelationship);

  static Future<void> replaceTo() => Modular.to.pushReplacementNamed(kHomeTasksScreenRoute);

  const TasksPage({
    Key? key,
    this.therapistPatientRelationship,
  }) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends BaseState<TasksPage, TasksController> {
  @override
  void initState() {
    controller.initialize(widget.therapistPatientRelationship);
    super.initState();
  }

  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => Modular.to.path == kTasksScreenRoute
      ? AppBar(
          title: const Text("Tarefas"),
        )
      : null;

  @override
  Widget? get floatingActionButton => Observer(
        builder: (context) => controller.shouldShowCreateButton
            ? FloatingActionButton(
                onPressed: controller.onTapAddEditTask,
                backgroundColor: AppColorScheme.primaryButtonBackground,
                child: const Icon(Icons.add, color: Colors.white),
              )
            : const SizedBox(),
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
          return Observer(builder: (_) {
            return ListTile(
              title: Text(task.task),
              trailing: Text(task.date.format),
              subtitle: Text(task.status.friendlyName),
              leading: Checkbox(
                onChanged: (value) => controller.onTapCheckbox(task),
                value: controller.isTaskChecked(task),
                visualDensity: VisualDensity.compact,
              ),
              onTap: () => controller.onTapAddEditTask(task),
              textColor: task.status.color,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s24,
                vertical: AppSpacing.s4,
              ),
            );
          });
        },
      );
    });
  }
}
