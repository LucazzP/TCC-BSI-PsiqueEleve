// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_edit_appointment_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddEditAppointmentController
    on _AddEditAppointmentControllerBase, Store {
  Computed<String>? _$titleComputed;

  @override
  String get title => (_$titleComputed ??= Computed<String>(() => super.title,
          name: '_AddEditAppointmentControllerBase.title'))
      .value;
  Computed<bool>? _$shouldShowGoToTasksButtonComputed;

  @override
  bool get shouldShowGoToTasksButton => (_$shouldShowGoToTasksButtonComputed ??=
          Computed<bool>(() => super.shouldShowGoToTasksButton,
              name:
                  '_AddEditAppointmentControllerBase.shouldShowGoToTasksButton'))
      .value;
  Computed<bool>? _$isOnlyViewComputed;

  @override
  bool get isOnlyView =>
      (_$isOnlyViewComputed ??= Computed<bool>(() => super.isOnlyView,
              name: '_AddEditAppointmentControllerBase.isOnlyView'))
          .value;

  @override
  String toString() {
    return '''
title: ${title},
shouldShowGoToTasksButton: ${shouldShowGoToTasksButton},
isOnlyView: ${isOnlyView}
    ''';
  }
}
