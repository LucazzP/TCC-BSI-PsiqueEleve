import 'dart:io';

import 'flavor/flavor_config.model.dart';
import 'flavor/flavor_values.model.dart';

import 'features.dart';

final kTestMode = Platform.environment.containsKey('FLUTTER_TEST');

FlavorValues get flavor => FlavorConfig.values();

final kFlavorDev = FlavorValues(
  baseUrl: kBaseUrlSupabase,
  publicAnonKey: _kPublicAnonKey,
  features: () => Features.dev,
);

final kFlavorQa = FlavorValues(
  baseUrl: kBaseUrlSupabase,
  publicAnonKey: _kPublicAnonKey,
  features: () => Features.qa,
);

final kFlavorProd = FlavorValues(
  baseUrl: kBaseUrlSupabase,
  publicAnonKey: _kPublicAnonKey,
  features: () => Features.prod,
);

const kLocalhost = 'http://localhost';
const kLocalhostAndroid = 'http://10.0.2.2';
const kBaseUrlSupabase = 'https://jrljsykpsirwgfvyeapa.supabase.co';
const _kPublicAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpybGpzeWtwc2lyd2dmdnllYXBhIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDc5ODk0MTAsImV4cCI6MTk2MzU2NTQxMH0.L4boSYZFW9VPeItSQvSzcqLBDj8TX0b-hn1D-yO67Ns';