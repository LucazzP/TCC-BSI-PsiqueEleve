import 'package:flutter/cupertino.dart';

import 'app_color_scheme.dart';

class AppBoxShadow {
  static List<BoxShadow> get standard => const [
        BoxShadow(
          color: AppColorScheme.shadow,
          spreadRadius: 0,
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get onlyTop => const [
        BoxShadow(
          color: AppColorScheme.shadow,
          blurRadius: 20,
          spreadRadius: 0,
          offset: Offset(0, 4),
        ),
        BoxShadow(
          color: AppColorScheme.background,
          blurRadius: 0,
          spreadRadius: 0,
          offset: Offset(0, 50),
        ),
      ];
}
