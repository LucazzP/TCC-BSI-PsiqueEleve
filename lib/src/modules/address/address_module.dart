import 'package:flutter_modular/flutter_modular.dart';
import 'package:psique_eleve/src/modules/address/data/datasource/address.datasource.dart';
import 'package:psique_eleve/src/modules/address/data/datasource/address_impl.datasource.dart';
import 'package:psique_eleve/src/modules/address/data/repository/address_impl.repository.dart';
import 'package:psique_eleve/src/modules/address/domain/repository/address.repository.dart';
import 'package:psique_eleve/src/modules/address/domain/usecases/create_address.usecase.dart';
import 'package:psique_eleve/src/modules/address/domain/usecases/update_address.usecase.dart';
import 'package:psique_eleve/src/modules/address/presentation/address_controller.dart';
import 'package:psique_eleve/src/modules/address/presentation/address_page.dart';

class AddressModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AddressController()),
    Bind.factory((i) => CreateAddressUseCase(i()), export: true),
    Bind.factory((i) => UpdateAddressUseCase(i()), export: true),
    Bind.factory<AddressRepository>((i) => AddressRepositoryImpl(i()), export: true),
    Bind.factory<AddressDataSource>((i) => AddressDataSourceImpl(i()), export: true),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => AddressPage(address: args.data),
    ),
  ];
}
