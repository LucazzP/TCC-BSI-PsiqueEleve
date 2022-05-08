import 'package:equatable/equatable.dart';
import 'package:psique_eleve/src/modules/appointment/domain/constants/status.enum.dart';

class AppointmentEntity extends Equatable {
  final String id;
  final DateTime date;
  final String patientReport;
  final String responsibleReport;
  final Status status;
  final DateTime createdAt;

  const AppointmentEntity({
    required this.id,
    required this.date,
    required this.patientReport,
    required this.responsibleReport,
    required this.status,
    required this.createdAt,
  });

  AppointmentEntity copyWith({
    String? id,
    DateTime? date,
    String? patientReport,
    String? responsibleReport,
    Status? status,
    DateTime? createdAt,
  }) {
    return AppointmentEntity(
      id: id ?? this.id,
      date: date ?? this.date,
      patientReport: patientReport ?? this.patientReport,
      responsibleReport: responsibleReport ?? this.responsibleReport,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object> get props => [
      id,
      date,
      patientReport,
      responsibleReport,
      status,
      createdAt,
    ];
}
