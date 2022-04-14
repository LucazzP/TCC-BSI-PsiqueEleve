import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/routes.dart';
import 'package:psique_eleve/src/presentation/styles/app_color_scheme.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
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
  Widget? get bottomNavigationBar => Observer(
        builder: (context) => BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded), label: 'Consultas'),
            BottomNavigationBarItem(icon: Icon(Icons.task_alt_rounded), label: 'Tarefas'),
            BottomNavigationBarItem(icon: Icon(Icons.menu_rounded), label: 'Mais'),
          ],
          unselectedItemColor: AppColorScheme.primarySwatch[400],
          selectedItemColor: AppColorScheme.primaryDefault,
          onTap: controller.onTapChangePage,
          currentIndex: controller.activePage.value,
        ),
      );

  @override
  void initState() {
    controller.activePage.setValue(
      controller.screenRoutes.indexOf(Modular.to.navigateHistory.first.name),
    );
    super.initState();
  }

  @override
  Widget child(context, constrains) {
    return const RouterOutlet();
  }
}
