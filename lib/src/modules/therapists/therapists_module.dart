import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/therapists/presentation/therapists_controller.dart';
import 'package:psique_eleve/src/modules/therapists/presentation/therapists_page.dart';

class TherapistsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => TherapistsController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const TherapistsPage(),
    ),
  ];
}
