import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/address/address_module.dart';
import 'package:psique_eleve/src/modules/therapists/data/datasource/therapists.datasource.dart';
import 'package:psique_eleve/src/modules/therapists/data/datasource/therapists_impl.datasource.dart';
import 'package:psique_eleve/src/modules/therapists/data/repository/therapists_impl.repository.dart';
import 'package:psique_eleve/src/modules/therapists/domain/repository/therapists.repository.dart';
import 'package:psique_eleve/src/modules/therapists/domain/usecases/get_therapists.usecase.dart';
import 'package:psique_eleve/src/modules/therapists/presentation/add_therapist/add_therapist_controller.dart';
import 'package:psique_eleve/src/modules/therapists/presentation/add_therapist/add_therapist_page.dart';
import 'package:psique_eleve/src/modules/therapists/presentation/therapists/therapists_controller.dart';
import 'package:psique_eleve/src/modules/therapists/presentation/therapists/therapists_page.dart';
import 'package:psique_eleve/src/presentation/routes.dart';

class TherapistsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AddTherapistController()),
    Bind.lazySingleton((i) => TherapistsController(i())),
    Bind.factory((i) => GetTherapistsUseCase(i())),
    Bind.factory<TherapistsRepository>((i) => TherapistsRepositoryImpl(i())),
    Bind.factory<TherapistsDataSource>((i) => TherapistsDataSourceImpl(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const TherapistsPage(),
    ),
    ChildRoute(
      kTherapistAddScreenRoute.finalPath,
      child: (_, args) => const AddTherapistPage(),
    ),
    ModuleRoute(
      kAddressModuleRoute.finalPath,
      module: AddressModule(),
    ),
  ];
}
