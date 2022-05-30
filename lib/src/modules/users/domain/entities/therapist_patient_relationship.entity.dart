import 'package:equatable/equatable.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';

class TherapistPatientRelationshipEntity extends Equatable {
  final String id;
  final UserEntity patient;
  final UserEntity therapist;
  final List<UserEntity> responsibles;
  final bool active;
  final DateTime createdAt;

  const TherapistPatientRelationshipEntity({
    this.id = '',
    required this.therapist,
    required this.patient,
    this.responsibles = const [],
    this.active = true,
    required this.createdAt,
  });

  TherapistPatientRelationshipEntity copyWith({
    String? id,
    UserEntity? patient,
    UserEntity? therapist,
    List<UserEntity>? responsibles,
    bool? active,
    DateTime? createdAt,
  }) {
    return TherapistPatientRelationshipEntity(
      id: id ?? this.id,
      patient: patient ?? this.patient,
      therapist: therapist ?? this.therapist,
      responsibles: responsibles ?? this.responsibles,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      patient,
      therapist,
      responsibles,
      active,
      createdAt,
    ];
  }
}
