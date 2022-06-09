import 'package:equatable/equatable.dart';
import 'package:psique_eleve/src/modules/appointment/domain/constants/status.enum.dart';
import 'package:psique_eleve/src/modules/users/domain/entities/therapist_patient_relationship.entity.dart';

class TaskEntity extends Equatable {
  final String id;
  final String task;
  final Status status;
  final DateTime date;
  final int xp;
  final TherapistPatientRelationshipEntity therapistPatientRelationship;
  final DateTime createdAt;

  const TaskEntity({
    required this.id,
    required this.task,
    required this.status,
    required this.date,
    required this.xp,
    required this.therapistPatientRelationship,
    required this.createdAt,
  });

  TaskEntity copyWith({
    String? id,
    String? title,
    String? task,
    Status? status,
    DateTime? date,
    int? xp,
    TherapistPatientRelationshipEntity? therapistPatientRelationship,
    DateTime? createdAt,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      task: task ?? this.task,
      status: status ?? this.status,
      date: date ?? this.date,
      xp: xp ?? this.xp,
      therapistPatientRelationship:
          therapistPatientRelationship ?? this.therapistPatientRelationship,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object> get props => [
        id,
        task,
        status,
        date,
        xp,
        therapistPatientRelationship,
        createdAt,
      ];
}
