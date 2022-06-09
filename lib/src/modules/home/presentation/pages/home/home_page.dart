import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
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
        title: Observer(builder: (_) {
          return Text(controller.titlePage);
        }),
        actions: [
          Observer(
            builder: (context) {
              if (controller.shouldShowDropdownUserRole == false) return const SizedBox.shrink();
              return DropdownButton(
                items: controller.userRoles.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role.nameFriendly),
                  );
                }).toList(),
                onChanged: controller.onChangedUserRole,
                value: controller.selectedUserRole.value,
                underline: Container(),
                iconEnabledColor: Colors.white,
                dropdownColor: AppColorScheme.primaryDefault,
                style: const TextStyle(color: Colors.white),
              );
            },
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
        ],
      );

  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  Widget? get bottomNavigationBar => Observer(
        builder: (context) {
          final items = controller.getNavBarItems;
          if (items.length == 1) return const SizedBox.shrink();
          return BottomNavigationBar(
            items: items,
            unselectedItemColor: AppColorScheme.primarySwatch[400],
            selectedItemColor: AppColorScheme.primaryDefault,
            onTap: controller.onTapChangePage,
            currentIndex: controller.activePage.value,
          );
        },
      );

  @override
  void initState() {
    controller.initialize();
    super.initState();
  }

  @override
  Widget child(context, constrains) {
    return const RouterOutlet();
  }
}
