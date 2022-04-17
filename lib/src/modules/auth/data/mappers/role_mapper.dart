import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/role_entity.dart';

extension RoleMapper on RoleEntity {
  Map<String, dynamic> toMap() {
    return {
      if (id.isNotEmpty) 'id': id,
      'name': name,
      'can_manage_therapists': canManageTherapists,
      'can_manage_patients': canManagePatients,
      'can_manage_responsibles': canManageResponsibles,
      'can_manage_patient_therapist_relationships': canManagePatientTherapistRelationships,
      'can_manage_appointments': canManageAppointments,
      'can_manage_tasks': canManageTasks,
      'can_manage_achivements': canManageAchivements,
      'can_manage_rewards': canManageRewards,
    };
  }

  static RoleEntity fromMap(Map map) {
    return RoleEntity(
      id: map['id'],
      name: map['name'] ?? '',
      type: UserType.values.firstWhere(
        (element) => element.name == map['name'],
        orElse: () => UserType.patient,
      ),
      canManageTherapists: map['can_manage_therapists'] ?? false,
      canManagePatients: map['can_manage_patients'] ?? false,
      canManageResponsibles: map['can_manage_responsibles'] ?? false,
      canManagePatientTherapistRelationships:
          map['can_manage_patient_therapist_relationships'] ?? false,
      canManageAppointments: map['can_manage_appointments'] ?? false,
      canManageTasks: map['can_manage_tasks'] ?? false,
      canManageAchivements: map['can_manage_achivements'] ?? false,
      canManageRewards: map['can_manage_rewards'] ?? false,
    );
  }
}
