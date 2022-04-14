import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'flavor/flavor_config.model.dart';
import 'flavor/flavor_values.model.dart';

class RunApp {
  final Widget rootWidget;
  final FlavorValues flavorValues;
  final Flavor flavor;
  final Future<void> Function(FlutterErrorDetails errorDetails)? errorReporter;

  RunApp(
    this.rootWidget, {
    this.errorReporter,
    required this.flavorValues,
    this.flavor = Flavor.production,
  });

  Future<void> initialize() async {
    FlavorConfig(
      flavor: flavor,
      color: flavor == Flavor.dev ? Colors.green : Colors.deepPurpleAccent,
      values: flavorValues,
    );

    EquatableConfig.stringify = true;
    await Supabase.initialize(
      url: flavorValues.baseUrl,
      anonKey: flavorValues.publicAnonKey,
      debug: flavor == Flavor.dev && kDebugMode,
    );

    runApp(rootWidget);
  }
}
