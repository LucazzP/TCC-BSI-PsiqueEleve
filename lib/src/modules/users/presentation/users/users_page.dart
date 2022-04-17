import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/routes.dart';
import 'package:psique_eleve/src/presentation/styles/app_color_scheme.dart';

import 'users_controller.dart';

class UsersPage extends StatefulWidget {
  final UserType userType;

  static Future<void> navigateTo(UserType userType) => Modular.to.pushNamed(
        kUsersScreenRoute,
        arguments: userType,
      );

  const UsersPage({
    Key? key,
    required this.userType,
  }) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends BaseState<UsersPage, UsersController> {
  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => AppBar(
        title: const Text('Terapeutas'),
      );

  @override
  Widget? get floatingActionButton => FloatingActionButton(
        onPressed: controller.onTapAddUser,
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: AppColorScheme.primaryButtonBackground,
      );

  @override
  void initState() {
    controller.initialize(widget.userType);
    controller.getUsers();
    super.initState();
  }

  @override
  Widget child(context, constrains) {
    return Observer(builder: (context) {
      final users = controller.users.value;
      if (users.isEmpty && !controller.isLoading) {
        return const Center(
          child: Text('Nenhum terapeuta cadastrado'),
        );
      }
      return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final therapist = users[index];
          return ListTile(
            title: Text(therapist.fullName),
          );
        },
      );
    });
  }
}
