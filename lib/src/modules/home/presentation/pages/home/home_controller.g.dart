// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  Computed<bool>? _$shouldShowDropdownUserRoleComputed;

  @override
  bool get shouldShowDropdownUserRole =>
      (_$shouldShowDropdownUserRoleComputed ??= Computed<bool>(
              () => super.shouldShowDropdownUserRole,
              name: '_HomeControllerBase.shouldShowDropdownUserRole'))
          .value;
  Computed<String>? _$titlePageComputed;

  @override
  String get titlePage =>
      (_$titlePageComputed ??= Computed<String>(() => super.titlePage,
              name: '_HomeControllerBase.titlePage'))
          .value;
  Computed<List<UserType>>? _$userRolesComputed;

  @override
  List<UserType> get userRoles =>
      (_$userRolesComputed ??= Computed<List<UserType>>(() => super.userRoles,
              name: '_HomeControllerBase.userRoles'))
          .value;

  @override
  String toString() {
    return '''
shouldShowDropdownUserRole: ${shouldShowDropdownUserRole},
titlePage: ${titlePage},
userRoles: ${userRoles}
    ''';
  }
}
