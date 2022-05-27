import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/menu/presentation/menu_controller.dart';
import 'package:psique_eleve/src/modules/menu/presentation/menu_page.dart';

class MenuModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MenuController(i(), i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const MenuPage(),
    ),
  ];
}
