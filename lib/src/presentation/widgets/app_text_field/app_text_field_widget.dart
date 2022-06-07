import 'package:flutter/cupertino.dart';
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
  final bool isLoading;
  final bool enabled;
  final Iterable<String> autofillHints;
  final int maxLines;

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
    this.isLoading = false,
    this.enabled = true,
    this.autofillHints = const [],
    this.maxLines = 1,
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
          enabled: enabled,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          textCapitalization: textCapitalization,
          onSubmitted: onSubmitted,
          controller: controller,
          autofillHints: autofillHints,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: AppBorderRadius.tiny,
              borderSide: AppBorderSide.regular,
            ),
            errorText: errorText,
            contentPadding: EdgeInsets.symmetric(
              vertical: maxLines == 1 ? AppSpacing.s4 : AppSpacing.s12,
              horizontal: AppSpacing.s12,
            ),
            suffixIcon: isLoading ? const CupertinoActivityIndicator() : null,
          ),
        ),
      ],
    );
  }
}
