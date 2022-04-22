import 'dart:io';
import 'dart:ui';

import 'flavor/flavor_config.model.dart';
import 'flavor/flavor_values.model.dart';

import 'features.dart';

final kTestMode = Platform.environment.containsKey('FLUTTER_TEST');

FlavorValues get flavor => FlavorConfig.values();

final kFlavorDev = FlavorValues(
  baseUrl: kBaseUrlSupabase,
  publicAnonKey: _kPublicAnonKey,
  authCallbackUrlHostname: kAuthCallbackUrlHostname,
  features: () => Features.dev,
);

final kFlavorQa = FlavorValues(
  baseUrl: kBaseUrlSupabase,
  publicAnonKey: _kPublicAnonKey,
  authCallbackUrlHostname: kAuthCallbackUrlHostname,
  features: () => Features.qa,
);

final kFlavorProd = FlavorValues(
  baseUrl: kBaseUrlSupabase,
  publicAnonKey: _kPublicAnonKey,
  authCallbackUrlHostname: kAuthCallbackUrlHostname,
  features: () => Features.prod,
);

const k100msDuration = Duration(milliseconds: 100);
const kAnimationDuration = Duration(milliseconds: 300);
const defaultLanguage = Locale('pt');
const kLoginCallBackMobile = 'psiqueeleve://polazzo.dev/?';
// const kLoginCallBackWeb = 'https://polazzo.dev/#/?';
const kLoginCallBackWeb = 'http://localhost:3000/#/?';
const kLocalhost = 'http://localhost';
const kLocalhostAndroid = 'http://10.0.2.2';
const kBaseUrlSupabase = 'https://ezapyuztdbnwhdnhcwsn.supabase.co';
const kAuthCallbackUrlHostname = '/?';
const _kPublicAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV6YXB5dXp0ZGJud2hkbmhjd3NuIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDg3Nzc5MjMsImV4cCI6MTk2NDM1MzkyM30.lsw1S2Reiwlz5Mzryqk6au9qSJGU2NcNWla2DZnlqBw';
