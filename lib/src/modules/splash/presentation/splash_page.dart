import 'package:flutter/material.dart';
import 'package:psique_eleve/src/presentation/base/pages/base.page.dart';
import 'package:psique_eleve/src/presentation/images.dart';

import 'splash_controller.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key? key, this.title = "Splash"}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage, SplashController> {
  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => null;

  @override
  EdgeInsets get padding => const EdgeInsets.all(40);

  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  Widget child(context, constrains) {
    return Center(
      child: Image.asset(kLogoPsiqueEleveBig),
    );
  }
}
