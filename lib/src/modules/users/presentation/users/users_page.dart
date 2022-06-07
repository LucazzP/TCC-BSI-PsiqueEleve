import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/extensions/date_time.ext.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/users/domain/entities/therapist_patient_relationship.entity.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';
import 'package:psique_eleve/src/presentation/helpers/ui_helper.dart';
import 'package:psique_eleve/src/presentation/styles/app_color_scheme.dart';
import 'package:psique_eleve/src/presentation/styles/app_spacing.dart';
import 'package:psique_eleve/src/presentation/styles/app_text_theme.dart';
import 'package:psique_eleve/src/presentation/widgets/user_image/user_image_widget.dart';

import 'users_controller.dart';

class UsersPage extends StatefulWidget {
  final UserType userType;
  final bool isInSelectMode;
  final bool isMultiSelect;

  static Future<void> navigateTo(UserType userType) => Modular.to.pushNamed(
        kUsersScreenRoute,
        arguments: {
          'userType': userType,
        },
      );

  static Future<List<TherapistPatientRelationshipEntity>> navigateToSelect(
    UserType userType, {
    bool multiSelect = false,
  }) =>
      Modular.to.pushNamed<List<TherapistPatientRelationshipEntity>>(
        kUsersScreenRoute,
        arguments: {
          'userType': userType,
          'isInSelectMode': true,
          'isMultiSelect': false,
        },
      ).then((value) => value ?? []);

  const UsersPage({
    Key? key,
    required this.userType,
    this.isInSelectMode = false,
    this.isMultiSelect = false,
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
  Widget? get floatingActionButton => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.isMultiSelect) ...[
            FloatingActionButton(
              onPressed: controller.onTapFinishSelection,
              backgroundColor: AppColorScheme.feedbackSuccessBase,
              child: const Icon(Icons.check, color: Colors.white),
            ),
            UIHelper.verticalSpaceS16,
          ],
          FloatingActionButton(
            onPressed: controller.addEditUser,
            backgroundColor: AppColorScheme.primaryButtonBackground,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
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
            onTap: () => controller.onTapTile(user, widget.isInSelectMode, widget.isMultiSelect),
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
