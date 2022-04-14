import 'package:flutter/material.dart';

import 'app_theme_data.dart';

class AppColorScheme {
  static ColorScheme get colorScheme => AppThemeData.isDark ? colorSchemeDark : colorSchemeLight;

  static final ColorScheme colorSchemeLight = ColorScheme.fromSwatch(
    backgroundColor: const Color(0xffFFFFFF),
    accentColor: accentColor,
    primarySwatch: primarySwatch,
    errorColor: feedbackDangerBase,
  ).copyWith(onPrimary: white);

  static final ColorScheme colorSchemeDark = ColorScheme.fromSwatch(
    brightness: Brightness.dark,
    backgroundColor: const Color(0xff32353D),
    accentColor: accentColor,
    primarySwatch: primarySwatch,
    errorColor: feedbackDangerDark,
  ).copyWith(onPrimary: white);

  /// http://mcg.mbitson.com/
  static const MaterialColor primarySwatch = MaterialColor(0xFF009BB1, <int, Color>{
    50: primaryLightest,
    100: Color(0xFFB3E1E8),
    200: primaryLight,
    300: Color(0xFF4DB9C8),
    400: Color(0xFF26AABD),
    500: primaryDefault,
    600: primaryMedium,
    700: Color(0xFF0089A1),
    800: primaryDark,
    900: Color(0xFF006D88),
  });

  static const MaterialColor accentColor = MaterialColor(0xFF81E2FF, <int, Color>{
    100: accentLighest,
    200: accentDefault,
    400: primaryMedium,
    700: primaryDark,
  });

  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffFFFFFF);

  static const background = Colors.white;
  static const border = Color(0xFFEBEDED);
  static const shadow = Color(0x4B000000);
  static const bodyText = Color(0xFF202124);
  static const primaryDefault = Color(0xFF009BB1);
  static const primaryLightest = Color(0xFFE0F3F6);
  static const primaryLight = Color(0xFF80CDD8);
  static const primaryMedium = Color(0xFF0093AA);
  static const primaryDark = Color(0xFF007F98);
  static const accentLighest = Color(0xFFB4EEFF);
  static const accentDefault = Color(0xFF81E2FF);

  static const primaryButtonBackground = Color(0xff009BB1);
  static const negativeText = Color(0xff000000);
  static const primarySwatchDark = Color(0xff009cc9);
  static const inactiveText = Color(0xff000000);
  static const negativeTextBackground = Color(0xff000000);

  static const neutralDark = Color(0xff1f2933);
  static const feedbackDangerBase = Color(0xfff23548);
  static const feedbackDangerDark = Color(0xffcc2d3d);
  static const googleButton = Color.fromRGBO(231, 77, 60, 1);
  static const facebookButton = Color.fromRGBO(66, 103, 178, 1);
  static const appleButton = Color.fromRGBO(0, 0, 0, 1);
}
