import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psique_eleve/src/presentation/styles/app_border_radius.dart';
import 'package:psique_eleve/src/presentation/styles/app_border_side.dart';
import 'package:psique_eleve/src/presentation/styles/app_font_weight.dart';
import 'package:psique_eleve/src/presentation/styles/app_spacing.dart';
import 'package:psique_eleve/src/presentation/styles/app_text_theme.dart';

import '../../helpers/ui_helper.dart';

class AppTextFieldWidget extends StatelessWidget {
  final String title;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter> inputFormatters;
  final ValueChanged<String>? onSubmitted;
  final String? errorText;
  final TextEditingController? controller;

  const AppTextFieldWidget({
    Key? key,
    this.onChanged,
    this.title = '',
    this.keyboardType,
    this.obscureText = false,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters = const [],
    this.onSubmitted,
    this.errorText,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextTheme.textTheme.bodyText2?.copyWith(
            fontWeight: AppFontWeight.bold,
          ),
        ),
        UIHelper.verticalSpaceS12,
        TextField(
          onChanged: onChanged,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          textCapitalization: textCapitalization,
          onSubmitted: onSubmitted,
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: AppBorderRadius.tiny,
              borderSide: AppBorderSide.regular,
            ),
            errorText: errorText,
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppSpacing.s4,
              horizontal: AppSpacing.s12,
            ),
          ),
        ),
      ],
    );
  }
}
