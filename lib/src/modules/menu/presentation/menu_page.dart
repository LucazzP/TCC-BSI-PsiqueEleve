import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/menu/model/menu_option_model.dart';
import 'package:psique_eleve/src/modules/users/presentation/add_edit_user/add_edit_user_page.dart';
import 'package:psique_eleve/src/modules/users/presentation/users/users_page.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';
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

  late final List<MenuOptionModel> options;

  @override
  void initState() {
    controller.getUserLogged();
    options = [
      MenuOptionModel(
        title: 'Perfil',
        onTap: () {
          final user = controller.user.value;
          if (user != null) {
            AddEditUserPage.navigateToEdit(user, true);
          } else {
            Modular.to.pop();
          }
        },
      ),
      MenuOptionModel(
        title: 'Gerenciar Terapeutas',
        onTap: () => UsersPage.navigateTo(UserType.therapist),
      ),
      MenuOptionModel(
        title: 'Gerenciar Pacientes',
        onTap: () => UsersPage.navigateTo(UserType.patient),
      ),
      MenuOptionModel(title: 'Configurações', onTap: () {}),
    ];
    super.initState();
  }

  @override
  Widget child(context, constrains) {
    return ListView.builder(
      padding: super.padding.copyWith(left: 0, right: 0),
      itemBuilder: (context, index) {
        final item = options[index];
        return ListTile(
          title: Text(item.title),
          onTap: item.onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
        );
      },
      itemCount: options.length,
    );
  }
}
