import 'package:psique_eleve/src/modules/appointment/domain/constants/status.enum.dart';
import 'package:psique_eleve/src/modules/appointment/domain/entity/appointment.entity.dart';
import 'package:psique_eleve/src/modules/users/data/mappers/therapist_patient_relationship.mapper.dart';

extension AppointmentMapper on AppointmentEntity {
  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date.toIso8601String(),
        'therapist_report': therapistReport,
        'patient_report': patientReport,
        'responsible_report': responsibleReport,
        'therapist_patient_relationship': therapistPatientRelationship.toMap(),
        'xp': xp,
        'status': status.name,
        // 'created_at': createdAt.toIso8601String(),
      };

  static AppointmentEntity? fromMap(Map<dynamic, dynamic> map) {
    final therapistPatientRelationship =
        TherapistPatientRelationshipMapper.fromMap(map['therapist_patient_relationship']);
    if (map.isEmpty || therapistPatientRelationship == null) return null;
    return AppointmentEntity(
      id: map['id'] ?? '',
      date: DateTime.parse(map['date']),
      therapistReport: map['therapist_report'] ?? '',
      patientReport: map['patient_report'] ?? '',
      responsibleReport: map['responsible_report'] ?? '',
      therapistPatientRelationship: therapistPatientRelationship,
      xp: map['xp'] ?? 0,
      status: Status.values.firstWhere((e) => e.name == map['status'], orElse: () => Status.todo),
      createdAt: map['created_at'] == null ? DateTime.now() : DateTime.parse(map['created_at']),
    );
  }
}
