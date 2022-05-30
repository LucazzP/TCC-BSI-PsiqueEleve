import 'package:psique_eleve/src/modules/auth/data/mappers/user_mapper.dart';
import 'package:psique_eleve/src/modules/users/domain/entities/therapist_patient_relationship.entity.dart';

extension TherapistPatientRelationshipMapper on TherapistPatientRelationshipEntity {
  Map<String, dynamic> toMap({bool onlyUserFields = false}) {
    return {
      if (id.isNotEmpty) 'id': id,
      'patient_user': patient.toMap(onlyUserFields: onlyUserFields),
      'therapist_user': therapist.toMap(onlyUserFields: onlyUserFields),
      'responsibles': responsibles.map((e) => e.toMap(onlyUserFields: onlyUserFields)),
      'active': active,
      // 'created_at': createdAt.toIso8601String(),
    };
  }

  static TherapistPatientRelationshipEntity? fromMap(Map<String, dynamic> map) {
    final patient = UserMapper.fromMap(map['patient_user']);
    final therapist = UserMapper.fromMap(map['therapist_user']);
    if (map.isEmpty || patient == null || therapist == null) return null;
    return TherapistPatientRelationshipEntity(
      id: map['id'] ?? '',
      patient: patient,
      therapist: therapist,
      responsibles: (map['responsibles'] ?? []).map(UserMapper.fromMap).toList(),
      active: map['active'] ?? false,
      createdAt: map['created_at'] == null ? DateTime.now() : DateTime.parse(map['created_at']),
    );
  }
}
