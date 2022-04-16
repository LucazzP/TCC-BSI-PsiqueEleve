import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/address_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:psique_eleve/src/presentation/models/form_model.dart';
import 'package:psique_eleve/src/presentation/validators.dart';
part 'add_therapist_controller.g.dart';

class AddTherapistController = _AddTherapistControllerBase with _$AddTherapistController;

abstract class _AddTherapistControllerBase extends BaseStore with Store {
  final fullName = ValueStore<FormModel>(const FormModel(validator: Validators.fullName));
  final email = ValueStore<FormModel>(const FormModel(validator: Validators.email));
  final cpf = ValueStore<FormModel>(const FormModel(validator: Validators.cpf));
  final cellphone = ValueStore<FormModel>(const FormModel(validator: Validators.cellphone));
  final imageUrl = ValueStore<String>('');
  final address = ValueStore<AddressEntity?>(AddressEntity(
    street: 'Rua dos bobos',
    number: '1234',
    district: 'Centro',
    city: 'Curitiba',
    state: 'PR',
    country: 'Brasil',
    zipCode: '80010000',
    complement: 'Apto 41C',
  ));

  final newTherapist = ValueState<UserEntity?>(null);

  @override
  Iterable<ValueState> get getStates => [newTherapist];

  @override
  List<ValueStore<FormModel>> get getForms => [fullName, email, cpf, cellphone];

  void onNameChanged(String value) => fullName.setValue(fullName.value.copyWith(value: value));
  void onEmailChanged(String value) => email.setValue(email.value.copyWith(value: value));
  void onCpfChanged(String value) => cpf.setValue(cpf.value.copyWith(value: value));
  void onCellphoneChanged(String value) =>
      cellphone.setValue(cellphone.value.copyWith(value: value));

  void onTapCreateEdit() {
    if (validateForms() == false) return;
  }

  void onTapEditAddress() {}

  void onTapAddAddress() {}
}
