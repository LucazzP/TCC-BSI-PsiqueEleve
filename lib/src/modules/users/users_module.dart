import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/address/address_module.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/users/data/datasource/users.datasource.dart';
import 'package:psique_eleve/src/modules/users/data/datasource/users_impl.datasource.dart';
import 'package:psique_eleve/src/modules/users/data/repository/users_impl.repository.dart';
import 'package:psique_eleve/src/modules/users/domain/repository/users.repository.dart';
import 'package:psique_eleve/src/modules/users/domain/usecases/create_user.usecase.dart';
import 'package:psique_eleve/src/modules/users/domain/usecases/get_patients.usecase.dart';
import 'package:psique_eleve/src/modules/users/domain/usecases/get_therapists.usecase.dart';
import 'package:psique_eleve/src/modules/users/domain/usecases/update_user.usecase.dart';
import 'package:psique_eleve/src/modules/users/presentation/users/users_controller.dart';
import 'package:psique_eleve/src/modules/users/presentation/users/users_page.dart';
import 'package:psique_eleve/src/presentation/constants/routes.dart';

import 'presentation/add_edit_user/add_edit_user_controller.dart';
import 'presentation/add_edit_user/add_edit_user_page.dart';

class UsersModule extends Module {
  @override
  List<Module> get imports => [AddressModule()];

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AddEditUserController(i(), i())),
    Bind.lazySingleton((i) => UsersController(i(), i())),
    Bind.factory((i) => GetTherapistsUseCase(i())),
    Bind.factory((i) => GetPatientsUseCase(i())),
    Bind.factory((i) => CreateUserUseCase(i(), i())),
    Bind.factory((i) => UpdateUserUseCase(i(), i(), i())),
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
        bool isProfilePage = false;
        UserType? userType;
        if (args.data is Map) {
          user = args.data['user'];
          isProfilePage = args.data['isProfilePage'] ?? false;
        } else if (args.data is UserType) {
          userType = args.data;
        }
        return AddEditUserPage(userType: userType, user: user, isProfilePage: isProfilePage);
      },
    ),
    ModuleRoute(
      kAddressModuleRoute.finalPath,
      module: AddressModule(),
    ),
  ];
}
