import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/extensions/string.ext.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/address_entity.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/form.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:psique_eleve/src/presentation/constants/validators.dart';
import 'package:via_cep_flutter/via_cep_flutter.dart';

part 'address_controller.g.dart';

class AddressController = _AddressControllerBase with _$AddressController;

abstract class _AddressControllerBase extends BaseStore with Store {
  final street = FormStore(Validators.minLenght(3));
  final number = FormStore(Validators.minLenght(1));
  final complement = FormStore((_) => null);
  final district = FormStore(Validators.minLenght(3));
  final city = FormStore(Validators.minLenght(3));
  final state = FormStore(Validators.minLenght(3));
  final zipCode = FormStore(Validators.minLenght(3));
  final zipCodeIsLoading = ValueStore(false);
  late final String id;
  bool get pageIsForEditing => id.isNotEmpty;
  String get getCreateEditValue => pageIsForEditing ? 'Editar' : 'Adicionar';

  @override
  Iterable<ValueState> get getStates => [];

  @override
  List<FormStore> get getForms => [
        street,
        number,
        complement,
        district,
        city,
        state,
        zipCode,
      ];

  void initialize(AddressEntity? address) {
    id = address?.id ?? '';
    if (address == null) return;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      street.setValue(address.street);
      number.setValue(address.number);
      complement.setValue(address.complement);
      district.setValue(address.district);
      city.setValue(address.city);
      state.setValue(address.state);
      zipCode.setValue(address.zipCode.withZipCodeMask);
    });
  }

  Future<void> onZipCodeChanged() async {
    final _zipCode = zipCode.value.replaceAll('-', '');
    if (_zipCode.length < 8) return;
    zipCodeIsLoading.setValue(true);
    final address = await readAddressByCep(_zipCode).whenComplete(
      () => zipCodeIsLoading.setValue(false),
    );
    if (address.isEmpty) return;
    if (address['city'] != null) city.setValue(address['city']);
    if (address['neighborhood'] != null) district.setValue(address['neighborhood']);
    if (address['state'] != null) state.setValue(address['state']);
    if (address['street'] != null) street.setValue(address['street']);
  }

  void onTapCreateEdit() {
    // if (validateForms() == false) return;
    Modular.to.pop(AddressEntity(
      id: id,
      country: 'Brasil',
      street: street.value,
      number: number.value,
      complement: complement.value,
      district: district.value,
      city: city.value,
      state: state.value,
      zipCode: zipCode.value.removeAllMasks,
    ));
  }
}
