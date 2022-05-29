import 'package:psique_eleve/src/modules/users/domain/entities/therapist_patient_relationship.entity.dart';

extension TherapistPatientRelationshipMapper on TherapistPatientRelationshipEntity {
  Map<String, dynamic> toMap() {
    return {
      if (id.isNotEmpty) 'id': id,
      'patient_user_id': patientId,
      'therapist_user_id': therapistId,
      'active': active,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  static TherapistPatientRelationshipEntity fromMap(Map<String, dynamic> map) {
    return TherapistPatientRelationshipEntity(
      id: map['id'] ?? '',
      patientId: map['patient_user_id'] ?? '',
      therapistId: map['therapist_user_id'] ?? '',
      active: map['active'] ?? false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
    );
  }
}