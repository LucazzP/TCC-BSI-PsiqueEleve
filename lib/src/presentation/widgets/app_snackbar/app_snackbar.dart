import 'package:flutter/material.dart';
import 'package:psique_eleve/src/presentation/styles/app_color_scheme.dart';
import 'package:psique_eleve/src/presentation/styles/app_text_theme.dart';

class AppSnackBar {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> success(
    BuildContext context,
    String message,
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextTheme.textTheme.bodyText2?.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColorScheme.feedbackSuccessBase,
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> error(
    BuildContext context,
    String message,
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextTheme.textTheme.bodyText2?.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColorScheme.feedbackDangerBase,
      ),
    );
  }
}
