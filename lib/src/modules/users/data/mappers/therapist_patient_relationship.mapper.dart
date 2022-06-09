import 'package:psique_eleve/src/modules/auth/data/mappers/user_mapper.dart';
import 'package:psique_eleve/src/modules/users/domain/entities/therapist_patient_relationship.entity.dart';

extension TherapistPatientRelationshipMapper on TherapistPatientRelationshipEntity {
  Map<String, dynamic> toMap({bool onlyUserFields = false}) {
    return {
      if (id.isNotEmpty) 'id': id,
      'patient_user': patient.toMap(onlyUserFields: onlyUserFields),
      'patient_user_id': patient.id,
      'therapist_user': therapist.toMap(onlyUserFields: onlyUserFields),
      'therapist_user_id': therapist.id,
      'active': active,
      'xp': xp,
      // 'created_at': createdAt.toIso8601String(),
    };
  }

  static TherapistPatientRelationshipEntity? fromMap(Map map) {
    if (map.isEmpty) return null;
    final patient = UserMapper.fromMap(map['patient']);
    final therapist = UserMapper.fromMap(map['therapist']);
    if (patient == null || therapist == null) return null;
    return TherapistPatientRelationshipEntity(
      id: map['id'] ?? '',
      patient: patient,
      therapist: therapist,
      xp: map['xp'] ?? 0,
      active: map['active'] ?? false,
      createdAt: map['created_at'] == null ? DateTime.now() : DateTime.parse(map['created_at']),
    );
  }
}
