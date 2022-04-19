import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/address_entity.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/base/pages/reaction.dart';
import 'package:psique_eleve/src/presentation/constants/masks.dart';
import 'package:psique_eleve/src/presentation/helpers/ui_helper.dart';
import 'package:psique_eleve/src/presentation/helpers/upper_case_text_formatter.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';
import 'package:psique_eleve/src/presentation/widgets/app_button/app_button.dart';
import 'package:psique_eleve/src/presentation/widgets/app_text_field/app_text_field_widget.dart';

import 'address_controller.dart';

class AddressPage extends StatefulWidget {
  final AddressEntity? address;

  static Future<AddressEntity?> navigateTo([AddressEntity? address]) => Modular.to.pushNamed(
        kAddressScreenRoute,
        arguments: address,
      );

  const AddressPage({Key? key, this.address}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends BaseState<AddressPage, AddressController> {
  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => AppBar(
        title: Text('${controller.getCreateEditValue} endereço'),
      );

  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  void initState() {
    controller.initialize(widget.address);
    super.initState();
  }

  @override
  get reaction => [
        Reaction(() => controller.zipCode.value, (value) => controller.onZipCodeChanged()),
      ];

  @override
  Widget child(context, constrains) {
    return WillPopScope(
      onWillPop: () async {
        controller.onTapCreateEdit();
        return false;
      },
      child: ListView(
        padding: super.padding,
        physics: const BouncingScrollPhysics(parent: ClampingScrollPhysics()),
        children: [
          Observer(builder: (_) {
            return AppTextFieldWidget(
              title: 'CEP',
              controller: controller.zipCode.controller,
              errorText: controller.zipCode.error,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: [TextInputMask(mask: kZipCodeMask)],
              isLoading: controller.zipCodeIsLoading.value,
            );
          }),
          UIHelper.verticalSpaceS12,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Observer(builder: (_) {
                  return AppTextFieldWidget(
                    title: 'Estado',
                    controller: controller.state.controller,
                    errorText: controller.state.error,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    inputFormatters: [TextInputMask(mask: kStateMask), UpperCaseTextFormatter()],
                    textCapitalization: TextCapitalization.characters,
                  );
                }),
              ),
              UIHelper.horizontalSpaceS12,
              Expanded(
                child: Observer(builder: (_) {
                  return AppTextFieldWidget(
                    title: 'Cidade',
                    controller: controller.city.controller,
                    errorText: controller.city.error,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                  );
                }),
              ),
            ],
          ),
          UIHelper.verticalSpaceS12,
          Observer(builder: (_) {
            return AppTextFieldWidget(
              title: 'Rua',
              controller: controller.street.controller,
              errorText: controller.street.error,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.streetAddress,
              textCapitalization: TextCapitalization.words,
            );
          }),
          UIHelper.verticalSpaceS12,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Observer(builder: (_) {
                  return AppTextFieldWidget(
                    title: 'Número',
                    controller: controller.number.controller,
                    errorText: controller.number.error,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  );
                }),
              ),
              UIHelper.horizontalSpaceS12,
              Expanded(
                child: Observer(builder: (_) {
                  return AppTextFieldWidget(
                    title: 'Complemento',
                    controller: controller.complement.controller,
                    errorText: controller.complement.error,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                  );
                }),
              ),
            ],
          ),
          UIHelper.verticalSpaceS12,
          Observer(builder: (_) {
            return AppTextFieldWidget(
              title: 'Bairro',
              controller: controller.district.controller,
              errorText: controller.district.error,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
            );
          }),
          UIHelper.verticalSpaceS32,
          AppButton(
            onPressed: controller.onTapCreateEdit,
            title: controller.getCreateEditValue,
            style: AppButtonStyle.filled,
          ),
          UIHelper.verticalSpaceS32,
        ],
      ),
    );
  }
}
