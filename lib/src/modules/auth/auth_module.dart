import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/auth/data/repository/auth_impl.repository.dart';
import 'package:psique_eleve/src/modules/auth/domain/repository/auth.repository.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:psique_eleve/src/presentation/routes.dart';

import 'data/datasource/auth.datasource.dart';
import 'data/datasource/auth_impl.datasource.dart';
import 'presentation/pages/login/login_controller.dart';
import 'presentation/pages/login/login_page.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginController()),
    Bind.factory((i) => GetUserLoggedUseCase(i()), export: true),
    Bind.factory<AuthRepository>((i) => AuthRepositoryImpl(i()), export: true),
    Bind.factory<AuthDataSource>((i) => AuthDataSourceImpl(i()), export: true),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      kAuthLoginScreenRoute.finalPath,
      child: (_, args) => const LoginPage(),
      transition: TransitionType.noTransition,
    ),
  ];
}
