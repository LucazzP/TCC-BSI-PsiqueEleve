import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/modules/address/presentation/address_page.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/address_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/form.store.dart';
import 'package:psique_eleve/src/presentation/validators.dart';
part 'add_therapist_controller.g.dart';

class AddTherapistController = _AddTherapistControllerBase with _$AddTherapistController;

abstract class _AddTherapistControllerBase extends BaseStore with Store {
  final fullName = FormStore(Validators.fullName);
  final email = FormStore(Validators.email);
  final cpf = FormStore(Validators.cpf);
  final cellphone = FormStore(Validators.cellphone);
  final imageUrl = ValueStore<String>('');
  final address = ValueStore<AddressEntity?>(null);

  final newTherapist = ValueState<UserEntity?>(null);

  @override
  Iterable<ValueState> get getStates => [newTherapist];

  @override
  List<FormStore> get getForms => [fullName, email, cpf, cellphone];

  void onTapCreateEdit() {
    if (validateForms() == false) return;
  }

  void onTapEditAddress() {
    AddressPage.navigateTo(address.value);
  }

  void onTapAddAddress() {
    AddressPage.navigateTo();
  }
}
