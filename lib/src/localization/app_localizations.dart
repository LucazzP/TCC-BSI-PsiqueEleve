import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:psique_eleve/src/core/constants.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension S on AppLocalizations {
  static late AppLocalizations current;

  static Future<void> initialize(BuildContext context) async {
    final locale = Localizations.of<AppLocalizations>(context, AppLocalizations);
    if (locale == null) {
      current = await AppLocalizations.delegate.load(defaultLanguage);
    } else {
      current = locale;
    }
  }
}
