import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:psique_eleve/src/extensions/string.ext.dart';
import 'package:psique_eleve/src/modules/address/presentation/address_page.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/address_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:psique_eleve/src/modules/users/domain/entities/therapist_patient_relationship.entity.dart';
import 'package:psique_eleve/src/modules/users/domain/usecases/create_user.usecase.dart';
import 'package:psique_eleve/src/modules/users/domain/usecases/get_user.usecase.dart';
import 'package:psique_eleve/src/modules/users/domain/usecases/update_user.usecase.dart';
import 'package:psique_eleve/src/presentation/base/controller/base.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/form.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value.store.dart';
import 'package:psique_eleve/src/presentation/base/controller/value_state.store.dart';
import 'package:psique_eleve/src/presentation/constants/validators.dart';
import 'package:psique_eleve/src/presentation/widgets/custom_alert_dialog/custom_alert_dialog.dart';

part 'add_edit_user_controller.g.dart';

class AddEditUserController = _AddEditUserControllerBase with _$AddEditUserController;

abstract class _AddEditUserControllerBase extends BaseStore with Store {
  final CreateUserUseCase _createUserUseCase;
  final UpdateUserUseCase _updateUserUseCase;
  final GetUserLoggedUseCase _getUserLoggedUseCase;
  final GetUserUseCase _getUserUseCase;

  _AddEditUserControllerBase(
    this._createUserUseCase,
    this._updateUserUseCase,
    this._getUserLoggedUseCase,
    this._getUserUseCase,
  );

  UserType? _userType;
  late final String userId;
  late final bool isProfilePage;

  final fullName = FormStore(Validators.fullName);
  final email = FormStore(Validators.email);
  final cpf = FormStore(Validators.cpf);
  final cellphone = FormStore(Validators.cellphone);
  final imageUrl = ValueStore<String>('');
  final address = ValueStore<AddressEntity?>(null);

  final linkedWith = ValueStore<UserEntity?>(null);

  final newUser = ValueState<UserEntity?>(null);
  final currentLoggedUser = ValueState<UserEntity?>(null);

  bool get pageIsForEditing => userId.isNotEmpty;
  String get getCreateEditValue => pageIsForEditing ? 'Editar' : 'Criar';
  String get getSuccessMessage =>
      pageIsForEditing ? 'Usuário editado com sucesso!' : 'Usuário criado com sucesso!';

  @computed
  String get title {
    if (isProfilePage) {
      return '$getCreateEditValue perfil';
    }
    switch (userType) {
      case UserType.admin:
      case UserType.therapist:
        return '$getCreateEditValue terapeuta';
      case UserType.patient:
      case UserType.responsible:
        return '$getCreateEditValue paciente';
    }
  }

  @override
  Iterable<ValueState> get getStates => [newUser, currentLoggedUser];

  @override
  List<FormStore> get getForms => [fullName, email, cpf, cellphone];

  void initialize(UserType? userType, UserEntity? user, bool isProfilePage) {
    _userType = userType;
    newUser.setValue(user);
    userId = user?.id ?? '';
    this.isProfilePage = isProfilePage;
    _setFieldValues();
    _getCurrentLoggedUser();
    _getUser();
  }

  @computed
  bool get canLinkPatient =>
      pageIsForEditing && userType == UserType.patient && linkedWith.value == null;

  @computed
  UserType get userType => _userType ?? newUser.value?.role.type ?? UserType.patient;

  @computed
  String get getLinkedPatientText {
    if (linkedWith.value == null) return '';
    var text = 'Vinculado ';
    if (linkedWith.value?.id == currentLoggedUser.value?.id) {
      text += 'com você';
    } else {
      text += 'com ${linkedWith.value?.fullName}';
    }
    return text;
  }

  Future<bool> onTapCreateEdit(BuildContext context) async {
    if (validateForms() == false) return false;
    final user = UserEntity(
      id: userId,
      fullName: fullName.value,
      email: email.value,
      cpf: cpf.value.removeAllMasks,
      cellphone: cellphone.value.removeAllMasks,
      imageUrl: imageUrl.value,
      address: address.value,
      roles: const [],
    );

    final linkedWithId = linkedWith.value?.id;
    final therapistPatientRelationship = linkedWithId == null || userId.isEmpty
        ? null
        : TherapistPatientRelationshipEntity(
            patientId: userId,
            therapistId: linkedWithId,
            createdAt: DateTime.now(),
          );

    await newUser.execute(
      () => pageIsForEditing
          ? _updateUserUseCase(UpdateUserParams(
              user: user,
              userTypes: [userType],
              isProfilePage: isProfilePage,
              therapistPatientRelationship: therapistPatientRelationship,
            ))
          : _createUserUseCase(CreateUserParams(user: user, userTypes: [userType])),
    );

    if (hasFailure) return false;

    if (pageIsForEditing == false) {
      Clipboard.setData(ClipboardData(text: newUser.value?.password ?? ''));
      await CustomAlertDialog.createdUser(context, newUser.value?.password ?? '');
    }

    Modular.to.pop(true);
    return true;
  }

  Future<void> onTapAddEditAddress() async {
    final newAddress = await AddressPage.navigateTo(address.value);
    if (newAddress != null) address.setValue(newAddress);
  }

  Future<void> onTapLinkPatient() async {
    linkedWith.setValue(currentLoggedUser.value);
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
    linkedWith.setValue(user.therapist);
  }

  Future<void> _getCurrentLoggedUser() {
    return currentLoggedUser.execute(_getUserLoggedUseCase);
  }

  Future<void> _getUser() async {
    if (pageIsForEditing) {
      await newUser.execute(() => _getUserUseCase.call(userId));
      _setFieldValues();
    }
  }
}
