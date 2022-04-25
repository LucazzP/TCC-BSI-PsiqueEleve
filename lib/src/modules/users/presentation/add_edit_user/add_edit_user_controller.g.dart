// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_edit_user_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddEditUserController on _AddEditUserControllerBase, Store {
  Computed<String>? _$titleComputed;

  @override
  String get title => (_$titleComputed ??= Computed<String>(() => super.title,
          name: '_AddEditUserControllerBase.title'))
      .value;
  Computed<bool>? _$canLinkPatientComputed;

  @override
  bool get canLinkPatient =>
      (_$canLinkPatientComputed ??= Computed<bool>(() => super.canLinkPatient,
              name: '_AddEditUserControllerBase.canLinkPatient'))
          .value;
  Computed<UserType>? _$userTypeComputed;

  @override
  UserType get userType =>
      (_$userTypeComputed ??= Computed<UserType>(() => super.userType,
              name: '_AddEditUserControllerBase.userType'))
          .value;
  Computed<String>? _$getLinkedPatientTextComputed;

  @override
  String get getLinkedPatientText => (_$getLinkedPatientTextComputed ??=
          Computed<String>(() => super.getLinkedPatientText,
              name: '_AddEditUserControllerBase.getLinkedPatientText'))
      .value;

  @override
  String toString() {
    return '''
title: ${title},
canLinkPatient: ${canLinkPatient},
userType: ${userType},
getLinkedPatientText: ${getLinkedPatientText}
    ''';
  }
}
