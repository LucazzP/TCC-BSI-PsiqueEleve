import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/home/presentation/pages/feed/feed_controller.dart';
import 'package:psique_eleve/src/presentation/routes.dart';

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
      transition: TransitionType.rightToLeftWithFade,
      children: [
        ChildRoute(
          kHomeFeedScreenRoute.finalPath,
          child: (_, args) => const FeedPage(),
        ),
      ]
    ),
  ];
}
