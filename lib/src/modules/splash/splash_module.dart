import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/splash_controller.dart';
import 'presentation/splash_page.dart';

class SplashModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SplashController(i()), export: true),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => SplashPage(initialUri: args.uri),
      transition: TransitionType.noTransition,
    ),
  ];
}
