import 'package:psique_eleve/src/modules/appointment/domain/constants/status.enum.dart';
import 'package:psique_eleve/src/modules/appointment/domain/entity/appointment.entity.dart';

extension AppointmentMapper on AppointmentEntity {
  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date.millisecondsSinceEpoch,
        'patient_report': patientReport,
        'responsible_report': responsibleReport,
        'status': status.name,
        'created_at': createdAt.millisecondsSinceEpoch,
      };

  static AppointmentEntity? fromMap(Map<dynamic, dynamic> map) => map.isEmpty
      ? null
      : AppointmentEntity(
          id: map['id'] ?? '',
          date: DateTime.fromMillisecondsSinceEpoch(map['date']),
          patientReport: map['patient_report'] ?? '',
          responsibleReport: map['responsible_report'] ?? '',
          status:
              Status.values.firstWhere((e) => e.name == map['status'], orElse: () => Status.todo),
          createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
        );
}
