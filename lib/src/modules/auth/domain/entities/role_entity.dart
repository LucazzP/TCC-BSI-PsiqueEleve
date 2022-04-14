import 'package:equatable/equatable.dart';

class RoleEntity extends Equatable {
  final String name;
  final bool canManageTherapists;
  final bool canManagePatients;
  final bool canManageResponsibles;
  final bool canManagePatientTherapistRelationships;
  final bool canManageAppointments;
  final bool canManageTasks;
  final bool canManageAchivements;
  final bool canManageRewards;

  const RoleEntity({
    this.name = '',
    this.canManageTherapists = false,
    this.canManagePatients = false,
    this.canManageResponsibles = false,
    this.canManagePatientTherapistRelationships = false,
    this.canManageAppointments = false,
    this.canManageTasks = false,
    this.canManageAchivements = false,
    this.canManageRewards = false,
  });

  RoleEntity copyWith({
    String? name,
    bool? canManageTherapists,
    bool? canManagePatients,
    bool? canManageResponsibles,
    bool? canManagePatientTherapistRelationships,
    bool? canManageAppointments,
    bool? canManageTasks,
    bool? canManageAchivements,
    bool? canManageRewards,
  }) {
    return RoleEntity(
      name: name ?? this.name,
      canManageTherapists: canManageTherapists ?? this.canManageTherapists,
      canManagePatients: canManagePatients ?? this.canManagePatients,
      canManageResponsibles: canManageResponsibles ?? this.canManageResponsibles,
      canManagePatientTherapistRelationships: canManagePatientTherapistRelationships ?? this.canManagePatientTherapistRelationships,
      canManageAppointments: canManageAppointments ?? this.canManageAppointments,
      canManageTasks: canManageTasks ?? this.canManageTasks,
      canManageAchivements: canManageAchivements ?? this.canManageAchivements,
      canManageRewards: canManageRewards ?? this.canManageRewards,
    );
  }

  @override
  List<Object> get props {
    return [
      name,
      canManageTherapists,
      canManagePatients,
      canManageResponsibles,
      canManagePatientTherapistRelationships,
      canManageAppointments,
      canManageTasks,
      canManageAchivements,
      canManageRewards,
    ];
  }
}
