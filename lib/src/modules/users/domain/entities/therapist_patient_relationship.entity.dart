import 'package:equatable/equatable.dart';

class TherapistPatientRelationshipEntity extends Equatable {
  final String id;
  final String patientId;
  final String therapistId;
  final bool active;
  final DateTime createdAt;
  
  const TherapistPatientRelationshipEntity({
    this.id = '',
    this.patientId = '',
    this.therapistId = '',
    this.active = true,
    required this.createdAt,
  });

  TherapistPatientRelationshipEntity copyWith({
    String? id,
    String? patientId,
    String? therapistId,
    bool? active,
    DateTime? createdAt,
  }) {
    return TherapistPatientRelationshipEntity(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      therapistId: therapistId ?? this.therapistId,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      patientId,
      therapistId,
      active,
      createdAt,
    ];
  }
}
