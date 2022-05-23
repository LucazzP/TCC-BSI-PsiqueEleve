import 'package:equatable/equatable.dart';
import 'package:psique_eleve/src/modules/appointment/domain/constants/status.enum.dart';

class AppointmentEntity extends Equatable {
  final String id;
  final DateTime date;
  final String therapistReport;
  final String patientReport;
  final String responsibleReport;
  final int xp;
  final Status status;
  final DateTime createdAt;

  const AppointmentEntity({
    required this.id,
    required this.date,
    required this.therapistReport,
    required this.patientReport,
    required this.responsibleReport,
    required this.xp,
    required this.status,
    required this.createdAt,
  });

  AppointmentEntity copyWith({
    String? id,
    DateTime? date,
    String? therapistReport,
    String? patientReport,
    String? responsibleReport,
    int? xp,
    Status? status,
    DateTime? createdAt,
  }) {
    return AppointmentEntity(
      id: id ?? this.id,
      date: date ?? this.date,
      therapistReport: therapistReport ?? this.therapistReport,
      patientReport: patientReport ?? this.patientReport,
      responsibleReport: responsibleReport ?? this.responsibleReport,
      xp: xp ?? this.xp,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object> get props => [
        id,
        date,
        therapistReport,
        patientReport,
        responsibleReport,
        xp,
        status,
        createdAt,
      ];
}
