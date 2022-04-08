import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/routes.dart';
import 'presentation/pages/home/home_controller.dart';

import 'presentation/pages/home/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const HomePage(route: kHomeScreenRoute),
    ),
  ];
}
