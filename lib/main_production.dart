import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/app_module.dart';
import 'package:psique_eleve/src/app_widget.dart';
import 'package:psique_eleve/src/core/constants.dart';
import 'package:psique_eleve/src/core/flavor/flavor_config.model.dart';
import 'package:psique_eleve/src/core/run_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  RunApp(
    ModularApp(
      module: AppModule(Flavor.production),
      child: const AppWidget(),
      debugMode: false,
    ),
    flavorValues: kFlavorProd,
    flavor: Flavor.production,
  ).initialize();
}
