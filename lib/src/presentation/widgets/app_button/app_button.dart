import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:psique_eleve/src/presentation/helpers/ui_helper.dart';
import 'package:psique_eleve/src/presentation/styles/app_color_scheme.dart';
import 'package:psique_eleve/src/presentation/styles/app_font_size.dart';
import 'package:psique_eleve/src/presentation/styles/app_theme_data.dart';

enum AppButtonColor { success, primary, emphasis }

enum AppButtonStyle { filled, bordered, clear, destructive, disabled }

extension AppButtonStyleExtension on AppButtonStyle {
  bool get showBackground {
    switch (this) {
      case AppButtonStyle.filled:
        return true;
      case AppButtonStyle.bordered:
        return false;
      case AppButtonStyle.clear:
        return false;
      case AppButtonStyle.destructive:
        return true;
      case AppButtonStyle.disabled:
        return true;
    }
  }

  bool get showBorder {
    switch (this) {
      case AppButtonStyle.filled:
        return false;
      case AppButtonStyle.bordered:
        return true;
      case AppButtonStyle.clear:
        return false;
      case AppButtonStyle.destructive:
        return false;
      case AppButtonStyle.disabled:
        return false;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case AppButtonStyle.filled:
        return AppColorScheme.primaryButtonBackground;
      case AppButtonStyle.bordered:
        return Colors.transparent;
      case AppButtonStyle.clear:
        return Colors.transparent;
      case AppButtonStyle.destructive:
        return AppColorScheme.negativeText;
      case AppButtonStyle.disabled:
        return AppColorScheme.primaryButtonBackground.withOpacity(0.2);
    }
  }

  Color get splashColor {
    switch (this) {
      case AppButtonStyle.filled:
        return AppColorScheme.negativeTextBackground.withOpacity(0.2);
      case AppButtonStyle.bordered:
        return AppColorScheme.primarySwatchDark.withOpacity(0.2);
      case AppButtonStyle.clear:
        return Colors.transparent;
      case AppButtonStyle.destructive:
        return AppColorScheme.negativeTextBackground.withOpacity(0.2);
      case AppButtonStyle.disabled:
        return Colors.transparent;
    }
  }

  Color get textColor {
    switch (this) {
      case AppButtonStyle.filled:
        return AppColorScheme.background;
      case AppButtonStyle.bordered:
        return AppThemeData.isDark == true
            ? AppColorScheme.bodyText
            : AppColorScheme.primaryButtonBackground;
      case AppButtonStyle.clear:
        return AppColorScheme.bodyText;
      case AppButtonStyle.destructive:
        return Colors.white;
      case AppButtonStyle.disabled:
        return AppColorScheme.background;
    }
  }

  Color get borderColor {
    switch (this) {
      case AppButtonStyle.filled:
        return AppColorScheme.primaryButtonBackground;
      case AppButtonStyle.bordered:
        return AppThemeData.isDark == true
            ? AppColorScheme.bodyText
            : AppColorScheme.primaryButtonBackground;
      case AppButtonStyle.clear:
        return Colors.transparent;
      case AppButtonStyle.destructive:
        return AppColorScheme.negativeText;
      case AppButtonStyle.disabled:
        return AppColorScheme.primaryButtonBackground;
    }
  }
}

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final AppButtonStyle style;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? fontSize;
  final FontWeight fontWeight;
  final double? width;
  final double height;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    required this.onPressed,
    required this.title,
    required AppButtonStyle style,
    this.fontSize = AppFontSize.secondary,
    this.fontWeight = FontWeight.bold,
    this.width,
    this.height = 44,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    Key? key,
  })  : style = onPressed == null ? AppButtonStyle.disabled : style,
        super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        width: width,
        child: RawMaterialButton(
          elevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          splashColor: style.splashColor,
          highlightElevation: 0,
          fillColor: style.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: BorderSide(
              color: style.showBorder ? style.borderColor : Colors.transparent,
              width: 1,
            ),
          ),
          onPressed: style == AppButtonStyle.disabled ? null : onPressed,
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (prefixIcon != null) ...[
                  prefixIcon ?? Container(),
                  UIHelper.horizontalSpaceS8,
                ],
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: style.textColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                    ),
                  ),
                ),
                if (suffixIcon != null) ...[
                  UIHelper.horizontalSpaceS8,
                  suffixIcon ?? Container(),
                ],
              ],
            ),
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
    properties.add(ObjectFlagProperty<Function()>.has('onPressed', onPressed));
    properties.add(EnumProperty<AppButtonStyle>('style', style));
    properties.add(DoubleProperty('fontSize', fontSize));
    properties.add(DiagnosticsProperty<FontWeight>('fontWeight', fontWeight));
    properties.add(DoubleProperty('width', width));
    properties.add(DoubleProperty('height', height));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry?>('padding', padding));
  }
}
