import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:psique_eleve/src/presentation/models/form_model.dart';
import 'package:psique_eleve/src/presentation/validators.dart';
part 'address_controller.g.dart';

class AddressController = _AddressControllerBase with _$AddressController;

abstract class _AddressControllerBase extends BaseStore with Store {
  final street = ValueStore<FormModel>(FormModel(validator: Validators.minLenght(3)));
  final number = ValueStore<FormModel>(FormModel(validator: Validators.minLenght(1)));
  final complement = ValueStore<FormModel>(FormModel(validator: (_) => null));
  final district = ValueStore<FormModel>(FormModel(validator: Validators.minLenght(3)));
  final city = ValueStore<FormModel>(FormModel(validator: Validators.minLenght(3)));
  final state = ValueStore<FormModel>(FormModel(validator: Validators.minLenght(3)));
  final zipCode = ValueStore<FormModel>(FormModel(validator: Validators.minLenght(3)));
  final country = ValueStore<FormModel>(FormModel(validator: Validators.minLenght(3)));

  @override
  Iterable<ValueState> get getStates => [];

  @override
  List<ValueStore<FormModel>> get getForms => [
        street,
        number,
        complement,
        district,
        city,
        state,
        zipCode,
        country,
      ];

  void onTapCreateEdit() {}
}
