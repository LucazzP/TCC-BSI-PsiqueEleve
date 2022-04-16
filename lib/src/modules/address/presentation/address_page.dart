import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/address_entity.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/helpers/ui_helper.dart';
import 'package:psique_eleve/src/presentation/routes.dart';
import 'package:psique_eleve/src/presentation/widgets/app_button/app_button.dart';
import 'package:psique_eleve/src/presentation/widgets/app_text_field/app_text_field_widget.dart';

import 'address_controller.dart';

class AddressPage extends StatefulWidget {
  final AddressEntity? address;

  static Future<void> navigateTo([AddressEntity? address]) => Modular.to.pushNamed(
        kAddressScreenRoute,
        arguments: address,
      );

  const AddressPage({Key? key, this.address}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends BaseState<AddressPage, AddressController> {
  String get getCreateEditValue => controller.pageIsForEditing ? 'Editar' : 'Criar';

  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => AppBar(
        title: Text('$getCreateEditValue Endereço'),
      );

  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  void initState() {
    controller.initialize(widget.address);
    super.initState();
  }

  @override
  Widget child(context, constrains) {
    return ListView(
      padding: super.padding,
      children: [
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'Rua',
            onChanged: controller.street.setValue,
            errorText: controller.street.error,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.streetAddress,
          );
        }),
        UIHelper.verticalSpaceS12,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'Número',
            onChanged: controller.number.setValue,
            errorText: controller.number.error,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
          );
        }),
        UIHelper.verticalSpaceS12,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'Complemento',
            onChanged: controller.complement.setValue,
            errorText: controller.complement.error,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
          );
        }),
        UIHelper.verticalSpaceS12,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'Bairro',
            onChanged: controller.district.setValue,
            errorText: controller.district.error,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
          );
        }),
        UIHelper.verticalSpaceS12,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'Cidade',
            onChanged: controller.city.setValue,
            errorText: controller.city.error,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
          );
        }),
        UIHelper.verticalSpaceS12,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'Estado',
            onChanged: controller.state.setValue,
            errorText: controller.state.error,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
          );
        }),
        UIHelper.verticalSpaceS12,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'CEP',
            onChanged: controller.zipCode.setValue,
            errorText: controller.zipCode.error,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            inputFormatters: [TextInputMask(mask: '00000-000')],
          );
        }),
        UIHelper.verticalSpaceS12,
        Observer(builder: (_) {
          return AppTextFieldWidget(
            title: 'Country',
            onChanged: controller.country.setValue,
            errorText: controller.country.error,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            controller: controller.countryController,
            onSubmitted: (_) => controller.onTapCreateEdit(),
          );
        }),
        UIHelper.verticalSpaceS32,
        AppButton(
          onPressed: controller.onTapCreateEdit,
          title: getCreateEditValue,
          style: AppButtonStyle.filled,
        ),
        UIHelper.verticalSpaceS32,
      ],
    );
  }
}
