import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/localization/app_localizations.dart';
import 'package:psique_eleve/src/presentation/styles/app_theme_data.dart';

import 'presentation/widgets/flavor_banner/flavor_banner.widget.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    initializeLocale(context);
    return MaterialApp.router(
      title: 'PsiqueEleve',
      theme: AppThemeData.themeDataLight,
      darkTheme: AppThemeData.themeDataLight,
      themeMode: ThemeMode.light,
      // Providing a restorationScopeId allows the Navigator built by the
      // MaterialApp to restore the navigation stack when a user leaves and
      // returns to the app after it has been killed while running in the
      // background.
      restorationScopeId: 'app',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt'),
      ],
      onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
      builder: (context, child) {
        AppThemeData.setIsDark(context, isDark: false);
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: FlavorBannerWidget(
            child: child ?? const SizedBox(),
          ),
        );
      },
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }

  Future<void> initializeLocale(BuildContext context) {
    final loadedLocale = Completer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      S.initialize(context);
      loadedLocale.complete();
    });

    return loadedLocale.future;
  }
}
