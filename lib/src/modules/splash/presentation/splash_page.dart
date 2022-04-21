import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/extensions/uri.ext.dart';
import 'package:psique_eleve/src/presentation/base/pages/auth.state.dart';
import 'package:psique_eleve/src/presentation/constants/images.dart';
import 'package:uni_links/uni_links.dart';

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
    recoverSessionUrl();
    super.initState();
  }

  void recoverSessionUrl() async {
    Uri? initialLink;
    try {
      initialLink = await getInitialUri();
    } catch (_) {}
    final uri = initialLink?.fromDeepLink ?? Uri.base;
    if (uri.queryParameters.isNotEmpty) {
      recoverSessionFromUrl(uri);
    }

    if (kIsWeb) return;
    uriLinkStream.listen((event) {
      if (event != null) {
        recoverSessionFromUrl(event.fromDeepLink);
      }
    });
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
