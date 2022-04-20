import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/core/flavor/flavor_config.model.dart';
import 'package:psique_eleve/src/data/local/hive_client.dart';
import 'package:psique_eleve/src/data/remote/interceptors/auth_interceptor.dart';
import 'package:psique_eleve/src/modules/logger/log.module.dart';
import 'package:psique_eleve/src/modules/splash/presentation/splash_page.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'data/remote/dio_client.dart';
import 'modules/auth/auth_module.dart';
import 'modules/home/home_module.dart';
import 'modules/splash/splash_module.dart';

class AppModule extends Module {
  final Flavor flavor;
  AppModule(this.flavor);

  @override
  final List<Module> imports = [
    LogModule(),
    AuthModule(),
    SplashModule(),
  ];

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => Dio()),
    Bind.lazySingleton((i) => AuthInterceptor(i(), () async => '', () async => '')),
    Bind.lazySingleton((i) => DioClient(i(), i())),
    Bind.lazySingleton((i) => HiveClient()),
    Bind.lazySingleton<SupabaseClient>((i) => Supabase.instance.client),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(kSplashScreenRoute.finalPath, module: SplashModule()),
    ModuleRoute(kHomeModuleRoute.finalPath, module: HomeModule()),
    ModuleRoute(kAuthModuleRoute.finalPath, module: AuthModule()),
    WildcardRoute(child: (_, args) => SplashPage(initialUri: args.uri)),
  ];
}
