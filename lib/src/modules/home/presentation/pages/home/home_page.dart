import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/routes.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  final screenRoutes = [
    kHomeFeedScreenRoute,
    kHomeFeedScreenRoute,
    kHomeFeedScreenRoute,
  ];

  @override
  PreferredSizeWidget appBar(BuildContext ctx) => AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
        ],
      );

  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  Widget? get bottomNavigationBar => BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) => Modular.to.navigate(screenRoutes[index]),
        currentIndex: screenRoutes.indexOf(Modular.to.navigateHistory.first.name),
      );

  @override
  Widget child(context, constrains) {
    return const RouterOutlet();
  }
}
