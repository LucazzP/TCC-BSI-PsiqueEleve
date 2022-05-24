import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/extensions/date_time.ext.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';
import 'package:psique_eleve/src/presentation/styles/app_color_scheme.dart';
import 'package:psique_eleve/src/presentation/styles/app_spacing.dart';
import 'package:psique_eleve/src/presentation/styles/app_text_theme.dart';
import 'package:psique_eleve/src/presentation/widgets/user_image/user_image_widget.dart';

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
        backgroundColor: AppColorScheme.primaryButtonBackground,
        child: const Icon(Icons.add, color: Colors.white),
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
          final userCreatedAt = user.createdAt;
          return ListTile(
            title: Text(user.fullName),
            subtitle: Text(
              user.email,
              style: AppTextTheme.textTheme.caption?.copyWith(
                color: AppColorScheme.black.withOpacity(0.5),
              ),
            ),
            trailing: userCreatedAt == null ? null : Text(userCreatedAt.format),
            leading: UserImageWidget(
              fullName: user.fullName,
              imageUrl: user.imageUrl,
              radius: 20,
            ),
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
