import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';
import 'package:psique_eleve/src/presentation/styles/app_color_scheme.dart';
import 'package:psique_eleve/src/presentation/styles/app_spacing.dart';

import 'menu_controller.dart';

class MenuPage extends StatefulWidget {
  static Future<void> navigateTo() => Modular.to.pushNamed(kHomeMenuScreenRoute);
  static Future<void> replaceTo() => Modular.to.pushReplacementNamed(kHomeMenuScreenRoute);

  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends BaseState<MenuPage, MenuController> {
  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => null;

  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  void initState() {
    controller.getUserLogged();
    super.initState();
  }

  @override
  Widget child(context, constrains) {
    return Observer(builder: (_) {
      final options = controller.options.value;
      return ListView.separated(
        itemBuilder: (context, index) {
          final item = options[index];
          return ListTile(
            title: Text(item.title),
            onTap: item.onTap,
            contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
            trailing: Icon(item.icon ?? Icons.chevron_right),
          );
        },
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          color: AppColorScheme.borderDark,
        ),
        itemCount: options.length,
      );
    });
  }
}
