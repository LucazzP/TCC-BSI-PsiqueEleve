import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/core/constants.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/users/presentation/widgets/address_card_widget.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/constants/masks.dart';
import 'package:psique_eleve/src/presentation/helpers/ui_helper.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';
import 'package:psique_eleve/src/presentation/widgets/app_button/app_button.dart';
import 'package:psique_eleve/src/presentation/widgets/app_snackbar/app_snackbar.dart';
import 'package:psique_eleve/src/presentation/widgets/app_text_field/app_text_field_widget.dart';
import 'package:psique_eleve/src/presentation/widgets/user_image/user_image_widget.dart';

import 'add_edit_user_controller.dart';

class AddEditUserPage extends StatefulWidget {
  final UserType? userType;
  final UserEntity? user;
  final bool isProfilePage;

  static Future<bool?> navigateToAdd(UserType userType) => Modular.to.pushNamed(
        kUserAddEditScreenRoute,
        arguments: userType,
      );

  static Future<bool?> navigateToEdit(UserEntity user, bool isProfilePage, {UserType? userType}) =>
      Modular.to.pushNamed(
        kUserAddEditScreenRoute,
        arguments: {
          'user': user,
          'isProfilePage': isProfilePage,
          'userType': userType,
        },
      );

  const AddEditUserPage({
    Key? key,
    this.userType,
    this.user,
    this.isProfilePage = false,
  }) : super(key: key);

  @override
  _AddEditUserPageState createState() => _AddEditUserPageState();
}

class _AddEditUserPageState extends BaseState<AddEditUserPage, AddEditUserController> {
  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => AppBar(
        title: Observer(builder: (_) {
          return Text(controller.title);
        }),
      );

  @override
  void initState() {
    controller.initialize(widget.userType, widget.user, widget.isProfilePage);
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
          return Center(
            child: UserImageWidget(
              imageUrl: controller.imageUrl.value,
              fullName: controller.fullName.value,
              onEdit: () {},
            ),
          );
        }),
        UIHelper.verticalSpaceS24,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'Nome completo',
            controller: controller.fullName.controller,
            errorText: controller.fullName.error,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            autofillHints: const [AutofillHints.name],
          );
        }),
        UIHelper.verticalSpaceS12,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'Email',
            controller: controller.email.controller,
            errorText: controller.email.error,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            enabled: controller.pageIsForEditing == false,
            autofillHints: const [AutofillHints.email],
          );
        }),
        UIHelper.verticalSpaceS12,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'CPF',
            controller: controller.cpf.controller,
            errorText: controller.cpf.error,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            inputFormatters: [TextInputMask(mask: kCpfMask)],
          );
        }),
        UIHelper.verticalSpaceS12,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'Telefone',
            controller: controller.cellphone.controller,
            errorText: controller.cellphone.error,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            inputFormatters: [TextInputMask(mask: kPhoneMask)],
            onSubmitted: (_) => createEditUser(),
            autofillHints: const [AutofillHints.telephoneNumberNational],
          );
        }),
        UIHelper.verticalSpaceS24,
        Observer(builder: (_) {
          final address = controller.address.value;
          if (address == null || address.isComplete() == false) {
            return AppButton(
              onPressed: controller.onTapAddEditAddress,
              title: 'Adicionar endere??o',
              style: AppButtonStyle.bordered,
            );
          }
          return AddressCardWidget(
            address: address,
            onTapEditAddress: controller.onTapAddEditAddress,
          );
        }),
        UIHelper.verticalSpaceS16,
        Observer(builder: (context) {
          var children = <Widget>[];
          if (controller.canLinkPatient) {
            children = [
              AppButton(
                onPressed: linkPatient,
                title: 'Vincular paciente',
                style: AppButtonStyle.bordered,
              ),
              UIHelper.verticalSpaceS12,
            ];
          }
          if (controller.getLinkedPatientText.isNotEmpty) {
            children = [
              Text(controller.getLinkedPatientText),
              UIHelper.verticalSpaceS12,
            ];
          }
          return Column(children: children);
        }),
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
    final success = await controller.onTapCreateEdit(context);
    if (success) {
      await Future.delayed(k100msDuration);
      AppSnackBar.success(context, controller.getSuccessMessage);
    }
  }

  void linkPatient() {
    controller.onTapLinkPatient();
  }
}
