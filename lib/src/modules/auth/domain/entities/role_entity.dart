import 'package:equatable/equatable.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';

class RoleEntity extends Equatable {
  final String id;
  final String name;
  final UserType type;
  final bool canManageTherapists;
  final bool canManagePatients;
  final bool canManageResponsibles;
  final bool canManagePatientTherapistRelationships;
  final bool canManageAppointments;
  final bool canManageTasks;
  final bool canManageAchivements;
  final bool canManageRewards;

  const RoleEntity({
    this.id = '',
    this.name = '',
    this.type = UserType.patient,
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
    String? id,
    String? name,
    UserType? type,
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
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      canManageTherapists: canManageTherapists ?? this.canManageTherapists,
      canManagePatients: canManagePatients ?? this.canManagePatients,
      canManageResponsibles: canManageResponsibles ?? this.canManageResponsibles,
      canManagePatientTherapistRelationships:
          canManagePatientTherapistRelationships ?? this.canManagePatientTherapistRelationships,
      canManageAppointments: canManageAppointments ?? this.canManageAppointments,
      canManageTasks: canManageTasks ?? this.canManageTasks,
      canManageAchivements: canManageAchivements ?? this.canManageAchivements,
      canManageRewards: canManageRewards ?? this.canManageRewards,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      type,
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
