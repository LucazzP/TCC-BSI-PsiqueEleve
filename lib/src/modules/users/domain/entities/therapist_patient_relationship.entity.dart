import 'package:equatable/equatable.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';

class TherapistPatientRelationshipEntity extends Equatable {
  final String id;
  final UserEntity patient;
  final UserEntity therapist;
  final int xp;
  final bool active;
  final DateTime createdAt;

  const TherapistPatientRelationshipEntity({
    this.id = '',
    required this.therapist,
    required this.patient,
    this.active = true,
    this.xp = 0,
    required this.createdAt,
  });

  TherapistPatientRelationshipEntity copyWith({
    String? id,
    UserEntity? patient,
    UserEntity? therapist,
    bool? active,
    DateTime? createdAt,
    int? xp,
  }) {
    return TherapistPatientRelationshipEntity(
      id: id ?? this.id,
      patient: patient ?? this.patient,
      therapist: therapist ?? this.therapist,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      xp: xp ?? this.xp,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      patient,
      therapist,
      active,
      createdAt,
      xp,
    ];
  }
}
