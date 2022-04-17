import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/address/address_module.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/users/data/datasource/users.datasource.dart';
import 'package:psique_eleve/src/modules/users/data/datasource/users_impl.datasource.dart';
import 'package:psique_eleve/src/modules/users/data/repository/users_impl.repository.dart';
import 'package:psique_eleve/src/modules/users/domain/repository/users.repository.dart';
import 'package:psique_eleve/src/modules/users/domain/usecases/get_therapists.usecase.dart';
import 'package:psique_eleve/src/modules/users/presentation/users/users_controller.dart';
import 'package:psique_eleve/src/modules/users/presentation/users/users_page.dart';
import 'package:psique_eleve/src/presentation/routes.dart';

import 'presentation/add_edit_user/add_edit_user_controller.dart';
import 'presentation/add_edit_user/add_edit_user_page.dart';

class UsersModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AddEditUserController()),
    Bind.lazySingleton((i) => UsersController(i())),
    Bind.factory((i) => GetUsersUseCase(i())),
    Bind.factory<UsersRepository>((i) => UsersRepositoryImpl(i())),
    Bind.factory<UsersDataSource>((i) => UsersDataSourceImpl(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => UsersPage(userType: args.data),
    ),
    ChildRoute(
      kUserAddEditScreenRoute.finalPath,
      child: (_, args) {
        UserEntity? user;
        UserType? userType;
        if (args.data is UserEntity) {
          user = args.data;
        } else if (args.data is UserType) {
          userType = args.data;
        }
        return AddEditUserPage(userType: userType, user: user);
      },
    ),
    ModuleRoute(
      kAddressModuleRoute.finalPath,
      module: AddressModule(),
    ),
  ];
}
