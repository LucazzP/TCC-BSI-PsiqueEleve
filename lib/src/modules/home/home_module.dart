import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/appointment/appointment_module.dart';
import 'package:psique_eleve/src/modules/home/presentation/pages/feed/feed_controller.dart';
import 'package:psique_eleve/src/modules/menu/menu_module.dart';
import 'package:psique_eleve/src/modules/tasks/tasks_module.dart';
import 'package:psique_eleve/src/modules/users/users_module.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';

import 'presentation/pages/feed/feed_page.dart';
import 'presentation/pages/home/home_controller.dart';
import 'presentation/pages/home/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeController()),
    Bind.lazySingleton((i) => FeedController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const HomePage(),
      children: [
        ChildRoute(
          kHomeFeedScreenRoute.finalPath,
          child: (_, args) => const FeedPage(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          kHomeAppointmentsScreenRoute.finalPath,
          module: AppointmentModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          kHomeTasksScreenRoute.finalPath,
          module: TasksModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          kHomeMenuScreenRoute.finalPath,
          module: MenuModule(),
          transition: TransitionType.noTransition,
        ),
      ],
    ),
    ModuleRoute(
      kUsersModuleRoute.finalPath,
      module: UsersModule(),
      // transition: TransitionType.rightToLeftWithFade,
    ),
  ];
}
