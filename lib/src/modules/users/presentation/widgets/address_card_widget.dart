import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/address_entity.dart';
import 'package:psique_eleve/src/presentation/helpers/ui_helper.dart';
import 'package:psique_eleve/src/presentation/styles/app_border_radius.dart';
import 'package:psique_eleve/src/presentation/styles/app_color_scheme.dart';
import 'package:psique_eleve/src/presentation/styles/app_spacing.dart';
import 'package:psique_eleve/src/presentation/styles/app_text_theme.dart';

class AddressCardWidget extends StatelessWidget {
  final VoidCallback? onTapEditAddress;
  final AddressEntity address;

  const AddressCardWidget({
    Key? key,
    this.onTapEditAddress,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.medium,
        border: Border.all(
          color: AppColorScheme.border,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s20,
        AppSpacing.s12,
        AppSpacing.s20,
        AppSpacing.s20,
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Text(
                'Endereço',
                style: AppTextTheme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold),
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  child: const Padding(
                    padding: EdgeInsets.all(AppSpacing.s4),
                    child: Icon(Icons.edit),
                  ),
                  onTap: onTapEditAddress,
                  borderRadius: AppBorderRadius.circular,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpaceS8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(address.street),
              Text(MagicMask.buildMask('99999-999').getMaskedString(address.zipCode)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${address.number}, ${address.complement.isNotEmpty ? (address.complement + ', ') : ''}${address.district}',
              ),
              Text(address.city + ' - ' + address.state),
            ],
          ),
        ],
      ),
    );
  }
}
