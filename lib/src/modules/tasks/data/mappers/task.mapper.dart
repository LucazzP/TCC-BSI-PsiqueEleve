import 'package:psique_eleve/src/modules/appointment/domain/constants/status.enum.dart';
import 'package:psique_eleve/src/modules/tasks/domain/entity/task.entity.dart';
import 'package:psique_eleve/src/modules/users/data/mappers/therapist_patient_relationship.mapper.dart';

extension TaskMapper on TaskEntity {
  Map<String, dynamic> toMap([bool onlyTaskFields = false]) {
    return {
      if (id.isNotEmpty) 'id': id,
      'task': task,
      'status': status.name,
      'date': date.toIso8601String(),
      'xp': xp,
      if (!onlyTaskFields) 'therapist_patient': therapistPatientRelationship.toMap(),
      // 'createdAt': createdAt.toIso8601String(),
    };
  }

  static TaskEntity? fromMap(Map<dynamic, dynamic> map) {
    final therapistPatientRelationship =
        TherapistPatientRelationshipMapper.fromMap(map['therapist_patient']);
    if (map.isEmpty || therapistPatientRelationship == null) return null;
    return TaskEntity(
      id: map['id'] ?? '',
      task: map['task'] ?? '',
      status: Status.values.firstWhere((e) => e.name == map['status'], orElse: () => Status.todo),
      date: DateTime.parse(map['date']),
      xp: map['xp']?.toInt() ?? 0,
      therapistPatientRelationship: therapistPatientRelationship,
      createdAt: map['created_at'] == null ? DateTime.now() : DateTime.parse(map['created_at']),
    );
  }
}
