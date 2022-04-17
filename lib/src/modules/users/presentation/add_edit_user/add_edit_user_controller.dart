import 'package:flinq/flinq.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/extensions/string.ext.dart';
import 'package:psique_eleve/src/modules/address/presentation/address_page.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/address_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/users/domain/usecases/create_user.usecase.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/form.store.dart';
import 'package:psique_eleve/src/presentation/constants/validators.dart';
import 'package:psique_eleve/src/presentation/widgets/custom_alert_dialog/custom_alert_dialog.dart';
part 'add_edit_user_controller.g.dart';

class AddEditUserController = _AddEditUserControllerBase with _$AddEditUserController;

abstract class _AddEditUserControllerBase extends BaseStore with Store {
  final CreateUserUseCase _createUserUseCase;

  _AddEditUserControllerBase(this._createUserUseCase);

  late final UserType userType;
  late final String id;
  late final bool isProfilePage;

  final fullName = FormStore(Validators.fullName);
  final email = FormStore(Validators.email);
  final cpf = FormStore(Validators.cpf);
  final cellphone = FormStore(Validators.cellphone);
  final imageUrl = ValueStore<String>('');
  final address = ValueStore<AddressEntity?>(null);
  final title = ValueStore('');

  final newUser = ValueState<UserEntity?>(null);

  bool get pageIsForEditing => id.isNotEmpty;
  String get getCreateEditValue => pageIsForEditing ? 'Editar' : 'Criar';

  @override
  Iterable<ValueState> get getStates => [newUser];

  @override
  List<FormStore> get getForms => [fullName, email, cpf, cellphone];

  void initialize(UserType? userType, UserEntity? user, bool isProfilePage) {
    this.userType = userType ?? user?.roles.firstOrNull?.type ?? UserType.patient;
    newUser.setValue(user);
    id = user?.id ?? '';
    this.isProfilePage = isProfilePage;
    _setStrings();
    _setFieldValues();
  }

  Future<void> onTapCreateEdit(BuildContext context) async {
    if (validateForms() == false) return;
    final user = UserEntity(
      id: id,
      fullName: fullName.value,
      email: email.value,
      cpf: cpf.value.removeAllMasks,
      cellphone: cellphone.value.removeAllMasks,
      imageUrl: imageUrl.value,
      address: address.value,
      roles: const [],
    );

    await newUser.execute(
      () => _createUserUseCase(CreateUserParams(user: user, userTypes: [userType])),
    );

    if (hasFailure) return;

    Clipboard.setData(ClipboardData(text: newUser.value?.password ?? ''));

    await CustomAlertDialog.createdUser(context, newUser.value?.password ?? '');

    Modular.to.pop(true);
  }

  Future<void> onTapAddEditAddress() async {
    final newAddress = await AddressPage.navigateTo(address.value);
    if (newAddress != null) address.setValue(newAddress);
  }

  void _setStrings() {
    if (isProfilePage) {
      return title.setValue('$getCreateEditValue perfil');
    }
    switch (userType) {
      case UserType.admin:
      case UserType.therapist:
        return title.setValue('$getCreateEditValue terapeuta');
      case UserType.patient:
      case UserType.responsible:
        return title.setValue('$getCreateEditValue paciente');
    }
  }

  void _setFieldValues() {
    final user = newUser.value;
    if (user == null) return;
    fullName.setValue(user.fullName);
    email.setValue(user.email);
    cpf.setValue(user.cpf.withCpfMask);
    cellphone.setValue(user.cellphone.withPhoneMask);
    imageUrl.setValue(user.imageUrl);
    address.setValue(user.address);
  }
}
