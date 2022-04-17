import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/users/presentation/widgets/address_card_widget.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/helpers/ui_helper.dart';
import 'package:psique_eleve/src/presentation/routes.dart';
import 'package:psique_eleve/src/presentation/widgets/app_button/app_button.dart';
import 'package:psique_eleve/src/presentation/widgets/app_text_field/app_text_field_widget.dart';
import 'package:psique_eleve/src/presentation/widgets/user_image/user_image_widget.dart';

import 'add_edit_user_controller.dart';

class AddEditUserPage extends StatefulWidget {
  final UserType? userType;
  final UserEntity? user;

  static Future<void> navigateToAdd(UserType userType) => Modular.to.pushNamed(
        kUserAddEditScreenRoute,
        arguments: userType,
      );

  static Future<void> navigateToEdit(UserEntity user) => Modular.to.pushNamed(
        kUserAddEditScreenRoute,
        arguments: user,
      );

  const AddEditUserPage({
    Key? key,
    this.userType,
    this.user,
  }) : super(key: key);

  @override
  _AddEditUserPageState createState() => _AddEditUserPageState();
}

class _AddEditUserPageState extends BaseState<AddEditUserPage, AddEditUserController> {
  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => AppBar(
        title: const Text('Adicionar terapeuta'),
      );

  @override
  void initState() {
    controller.initialize(widget.userType, widget.user);
    super.initState();
  }

  @override
  Widget child(context, constrains) {
    return ListView(
      physics: const BouncingScrollPhysics(parent: ClampingScrollPhysics()),
      children: [
        Observer(builder: (_) {
          return UserImageWidget(
            imageUrl: controller.imageUrl.value,
            fullName: controller.fullName.value,
            onEdit: () {},
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
          );
        }),
        UIHelper.verticalSpaceS12,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'Email',
            controller: controller.email.controller,
            errorText: controller.email.error,
            obscureText: true,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
          );
        }),
        UIHelper.verticalSpaceS12,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'CPF',
            controller: controller.cpf.controller,
            errorText: controller.cpf.error,
            obscureText: true,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
          );
        }),
        UIHelper.verticalSpaceS12,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'Telefone',
            controller: controller.cellphone.controller,
            errorText: controller.cellphone.error,
            obscureText: true,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => controller.onTapCreateEdit(),
          );
        }),
        UIHelper.verticalSpaceS24,
        Observer(builder: (_) {
          final address = controller.address.value;
          if (address == null || address.isComplete() == false) {
            return AppButton(
              onPressed: controller.onTapAddEditAddress,
              title: 'Adicionar endereço',
              style: AppButtonStyle.bordered,
            );
          }
          return AddressCardWidget(
            address: address,
            onTapEditAddress: controller.onTapAddEditAddress,
          );
        }),
        UIHelper.verticalSpaceS16,
        AppButton(
          onPressed: controller.onTapCreateEdit,
          title: 'Criar',
          style: AppButtonStyle.filled,
        ),
        UIHelper.verticalSpaceS32,
      ],
    );
  }
}
