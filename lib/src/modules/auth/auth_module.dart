import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/auth/data/repository/auth_impl.repository.dart';
import 'package:psique_eleve/src/modules/auth/domain/repository/auth.repository.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/login_email_usecase.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/logout.usecase.dart';
import 'package:psique_eleve/src/modules/auth/presentation/pages/reset_password/reset_password_controller.dart';
import 'package:psique_eleve/src/modules/auth/presentation/pages/reset_password/reset_password_page.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';

import 'data/datasource/local/auth_local.datasource.dart';
import 'data/datasource/local/auth_local_impl.datasource.dart';
import 'data/datasource/remote/auth_remote.datasource.dart';
import 'data/datasource/remote/auth_remote_impl.datasource.dart';
import 'presentation/pages/login/login_controller.dart';
import 'presentation/pages/login/login_page.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginController(i())),
    Bind.lazySingleton((i) => ResetPasswordController()),
    Bind.factory((i) => LoginEmailUseCase(i())),
    Bind.factory((i) => GetUserLoggedUseCase(i()), export: true),
    Bind.factory((i) => LogoutUseCase(i()), export: true),
    Bind.factory<AuthRepository>((i) => AuthRepositoryImpl(i(), i()), export: true),
    Bind.factory<AuthRemoteDataSource>((i) => AuthRemoteDataSourceImpl(i()), export: true),
    Bind.factory<AuthLocalDataSource>((i) => AuthLocalDataSourceImpl(i()), export: true),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      kAuthLoginScreenRoute.finalPath,
      child: (_, args) => const LoginPage(),
      transition: TransitionType.rightToLeftWithFade,
    ),
    ChildRoute(
      kAuthResetPasswordScreenRoute.finalPath,
      child: (_, args) => const ResetPasswordPage(),
    ),
  ];
}
