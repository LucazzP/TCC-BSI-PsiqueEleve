import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/tasks/presentation/add_edit_task/add_edit_task_controller.dart';
import 'package:psique_eleve/src/modules/tasks/presentation/add_edit_task/add_edit_task_page.dart';

import '../../presentation/constants/routes.dart';
import 'data/datasource/remote/tasks_remote.datasource.dart';
import 'data/datasource/remote/tasks_remote_impl.datasource.dart';
import 'data/repository/tasks_impl.repository.dart';
import 'domain/repository/tasks.repository.dart';
import 'domain/usecases/create_task.usecase.dart';
import 'domain/usecases/get_task.usecase.dart';
import 'domain/usecases/get_tasks.usecase.dart';
import 'domain/usecases/update_task.usecase.dart';
import 'presentation/tasks_controller.dart';
import 'presentation/tasks_page.dart';

class TasksModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => TasksController(i(), i(), i(), i())),
    Bind.lazySingleton((i) => AddEditTaskController(i(), i())),
    Bind.factory((i) => UpdateTaskUseCase(i())),
    Bind.factory((i) => CreateTaskUseCase(i())),
    Bind.factory((i) => GetTaskUseCase(i())),
    Bind.factory((i) => GetTasksUseCase(i())),
    Bind.factory<TasksRepository>((i) => TasksRepositoryImpl(i())),
    Bind.factory<TasksRemoteDataSource>((i) => TasksRemoteDataSourceImpl(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => TasksPage(therapistPatientRelationship: args.data),
    ),
    ChildRoute(
      kTaskAddEditScreenRoute.finalPath,
      child: (_, args) {
        final task = args.data['task'];
        final therapistPatientRelationship = args.data['therapistPatientRelationship'];

        return AddEditTaskPage(
          task: task,
          therapistPatientRelationship: therapistPatientRelationship,
        );
      },
    ),
  ];
}
