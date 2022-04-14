import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color_scheme.dart';

class AppTextTheme {
  /// https://material.io/design/typography/the-type-system.html#type-scale - Helps to create textTheme

  static TextTheme get textTheme => textThemeRoboto;

  static TextTheme textThemeRoboto = GoogleFonts.robotoTextTheme(TextTheme(
    headline1: GoogleFonts.roboto(
      fontSize: 96,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: AppColorScheme.bodyText,
    ),
    headline2: GoogleFonts.roboto(
      fontSize: 60,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: AppColorScheme.bodyText,
    ),
    headline3: GoogleFonts.roboto(
      fontSize: 48,
      fontWeight: FontWeight.w400,
      color: AppColorScheme.bodyText,
    ),
    headline4: GoogleFonts.roboto(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: AppColorScheme.bodyText,
    ),
    headline5: GoogleFonts.roboto(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: AppColorScheme.bodyText,
    ),
    headline6: GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: AppColorScheme.bodyText,
    ),
    subtitle1: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: AppColorScheme.bodyText,
    ),
    subtitle2: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: AppColorScheme.bodyText,
    ),
    bodyText1: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: AppColorScheme.bodyText,
    ),
    bodyText2: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: AppColorScheme.bodyText,
    ),
    button: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      color: AppColorScheme.bodyText,
    ),
    caption: GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: AppColorScheme.bodyText,
    ),
    overline: GoogleFonts.roboto(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: AppColorScheme.bodyText,
    ),
  ));
}
