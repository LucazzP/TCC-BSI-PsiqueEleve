import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/appointment/presentation/appointments_controller.dart';
import 'package:psique_eleve/src/modules/appointment/presentation/appointments_page.dart';

class AppointmentModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AppointmentsController()),
    
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const AppointmentsPage(),
    ),
  ];
}
