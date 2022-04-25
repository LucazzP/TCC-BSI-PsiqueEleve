import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';
import 'package:psique_eleve/src/presentation/styles/app_color_scheme.dart';
import 'package:psique_eleve/src/presentation/styles/app_spacing.dart';

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
        title: Observer(builder: (_) {
          return Text(controller.title.value);
        }),
      );

  @override
  Widget? get floatingActionButton => FloatingActionButton(
        onPressed: controller.onTapAddEditUser,
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
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  Widget child(context, constrains) {
    return Observer(builder: (context) {
      final users = controller.users.value;
      if (users.isEmpty && !controller.isLoading) {
        return Center(
          child: Text(controller.emptyMessage.value),
        );
      }
      return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user.fullName),
            onTap: () => controller.onTapAddEditUser(user),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s24,
              vertical: AppSpacing.s4,
            ),
          );
        },
      );
    });
  }
}
