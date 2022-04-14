import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/tasks/presentation/tasks_controller.dart';
import 'package:psique_eleve/src/modules/tasks/presentation/tasks_page.dart';

class TasksModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => TasksController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const TasksPage(),
    ),
  ];
}
