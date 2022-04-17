import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/modules/address/presentation/address_page.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/address_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/form.store.dart';
import 'package:psique_eleve/src/presentation/validators.dart';
part 'add_edit_user_controller.g.dart';

class AddEditUserController = _AddEditUserControllerBase with _$AddEditUserController;

abstract class _AddEditUserControllerBase extends BaseStore with Store {
  late final UserType userType;
  final fullName = FormStore(Validators.fullName);
  final email = FormStore(Validators.email);
  final cpf = FormStore(Validators.cpf);
  final cellphone = FormStore(Validators.cellphone);
  final imageUrl = ValueStore<String>('');
  final address = ValueStore<AddressEntity?>(null);

  final newUser = ValueState<UserEntity?>(null);

  @override
  Iterable<ValueState> get getStates => [newUser];

  @override
  List<FormStore> get getForms => [fullName, email, cpf, cellphone];

  void initialize(UserType? userType, UserEntity? user) {
    this.userType = userType ?? user?.roles.first.type ?? UserType.patient;
    newUser.setValue(user);
  }

  void onTapCreateEdit() {
    if (validateForms() == false) return;
  }

  Future<void> onTapAddEditAddress() async {
    final newAddress = await AddressPage.navigateTo(address.value);
    if (newAddress != null) address.setValue(newAddress);
  }
}
