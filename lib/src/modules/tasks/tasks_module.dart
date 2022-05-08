import 'package:flutter_modular/flutter_modular.dart';

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
    Bind.lazySingleton((i) => TasksController(i())),
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
      child: (_, args) => const TasksPage(),
    ),
  ];
}
