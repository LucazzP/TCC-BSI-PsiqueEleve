import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/core/constants.dart';
import 'package:psique_eleve/src/extensions/date_time.ext.dart';
import 'package:psique_eleve/src/modules/appointment/domain/constants/status.enum.dart';

import 'package:psique_eleve/src/modules/tasks/domain/entity/task.entity.dart';
import 'package:psique_eleve/src/modules/users/domain/entities/therapist_patient_relationship.entity.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';
import 'package:psique_eleve/src/presentation/helpers/ui_helper.dart';
import 'package:psique_eleve/src/presentation/styles/app_color_scheme.dart';
import 'package:psique_eleve/src/presentation/widgets/app_button/app_button.dart';
import 'package:psique_eleve/src/presentation/widgets/app_snackbar/app_snackbar.dart';
import 'package:psique_eleve/src/presentation/widgets/app_text_field/app_text_field_widget.dart';

import 'add_edit_task_controller.dart';

class AddEditTaskPage extends StatefulWidget {
  final TaskEntity? task;
  final TherapistPatientRelationshipEntity therapistPatientRelationship;

  static Future<bool?> navigateTo(
    TaskEntity? task,
    TherapistPatientRelationshipEntity therapistPatientRelationship,
  ) =>
      Modular.to.pushNamed(
        kTaskAddEditScreenRoute,
        arguments: {
          'task': task,
          'therapistPatientRelationship': therapistPatientRelationship,
        },
      );

  const AddEditTaskPage({
    Key? key,
    required this.task,
    required this.therapistPatientRelationship,
  }) : super(key: key);

  @override
  _AddEditTaskPageState createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends BaseState<AddEditTaskPage, AddEditTaskController> {
  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => AppBar(
        title: Observer(builder: (_) {
          return Text(controller.title);
        }),
      );

  @override
  void initState() {
    controller.initialize(widget.task, widget.therapistPatientRelationship);
    super.initState();
  }

  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  bool get safeAreaBottom => false;

  @override
  Widget child(context, constrains) {
    return ListView(
      physics: const BouncingScrollPhysics(parent: ClampingScrollPhysics()),
      padding: super.padding,
      children: [
        Observer(builder: (_) {
          return TextButton(
            onPressed: () => controller.selectDate(context),
            child: Text('Data: ${controller.date.value.formatWithHour} (toque para alterar)'),
          );
        }),
        UIHelper.verticalSpaceS12,
        Observer(builder: (_) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(color: AppColorScheme.border),
            ),
            child: DropdownButton(
              items: Status.values
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.friendlyName)))
                  .toList(),
              onChanged: (Status? status) => controller.status.setValue(status ?? Status.todo),
              value: controller.status.value,
              isExpanded: true,
              underline: const SizedBox(),
            ),
          );
        }),
        UIHelper.verticalSpaceS24,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'Tarefa',
            controller: controller.taskTitle.controller,
            errorText: controller.taskTitle.error,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            textCapitalization: TextCapitalization.sentences,
          );
        }),
        UIHelper.verticalSpaceS24,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'XP a receber',
            controller: controller.xp.controller,
            errorText: controller.xp.error,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => createEditUser(),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          );
        }),
        UIHelper.verticalSpaceS24,
        AppButton(
          onPressed: createEditUser,
          title: controller.getCreateEditValue,
          style: AppButtonStyle.filled,
        ),
        UIHelper.verticalSpaceS32,
      ],
    );
  }

  void createEditUser() async {
    final success = await controller.onTapCreateEdit();
    if (success) {
      await Future.delayed(k100msDuration);
      AppSnackBar.success(context, controller.getSuccessMessage);
    }
  }
}
