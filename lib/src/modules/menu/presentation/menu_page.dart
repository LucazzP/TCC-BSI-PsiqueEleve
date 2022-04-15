import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/menu/model/menu_option_model.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/routes.dart';
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
  Widget child(context, constrains) {
    return ListView.builder(
      padding: super.padding.copyWith(left: 0, right: 0),
      itemBuilder: (context, index) {
        final item = options[index];
        return ListTile(
          title: Text(item.title),
          onTap: () => Modular.to.pushNamed(item.route),
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
        );
      },
      itemCount: options.length,
    );
  }

  static const options = [
    MenuOptionModel(title: 'Perfil'),
    MenuOptionModel(title: 'Gerenciar Terapeutas', route: kTherapistsScreenRoute),
    MenuOptionModel(title: 'Gerenciar Pacientes'),
    MenuOptionModel(title: 'Configurações'),
  ];
}
