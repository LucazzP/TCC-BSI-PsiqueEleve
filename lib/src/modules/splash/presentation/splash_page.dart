import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/extensions/uri.ext.dart';
import 'package:psique_eleve/src/localization/app_localizations.dart';
import 'package:psique_eleve/src/presentation/base/pages/auth.state.dart';
import 'package:psique_eleve/src/presentation/constants/images.dart';

import 'splash_controller.dart';

class SplashPage extends StatefulWidget {
  final String title;
  final Uri initialUri;

  const SplashPage({
    Key? key,
    this.title = "Splash",
    required this.initialUri,
  }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends AuthState<SplashPage> {
  SplashController get controller => Modular.get();

  @override
  void initState() {
    controller.onInit();
    recoverSupabaseSession();
    recoverSessionFromUrl(Uri.base);
    super.initState();
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: Image.asset(kLogoPsiqueEleveBig),
      ),
    );
  }

  @override
  void dispose() {
    Modular.dispose<SplashController>();
    super.dispose();
  }
}
