import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/address_entity.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/form.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:psique_eleve/src/presentation/validators.dart';

part 'address_controller.g.dart';

class AddressController = _AddressControllerBase with _$AddressController;

abstract class _AddressControllerBase extends BaseStore with Store {
  final countryController = TextEditingController();
  final street = FormStore(Validators.minLenght(3));
  final number = FormStore(Validators.minLenght(1));
  final complement = FormStore((_) => null);
  final district = FormStore(Validators.minLenght(3));
  final city = FormStore(Validators.minLenght(3));
  final state = FormStore(Validators.minLenght(3));
  final zipCode = FormStore(Validators.minLenght(3));
  final country = FormStore(Validators.minLenght(3));
  late final bool pageIsForEditing;

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
        country,
      ];

  void initialize(AddressEntity? address) {
    pageIsForEditing = address != null;
    country.setValue(address?.country ?? 'Brasil');
    countryController.text = country.value;
    if (address == null) return;
    street.setValue(address.street);
    number.setValue(address.number);
    complement.setValue(address.complement);
    district.setValue(address.district);
    city.setValue(address.city);
    state.setValue(address.state);
    zipCode.setValue(address.zipCode);
  }

  void onTapCreateEdit() {}
}
