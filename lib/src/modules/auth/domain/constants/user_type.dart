enum UserType {
  admin,
  therapist,
  patient,
  responsible,
}

extension UserTypeExtension on UserType {
  String get nameFriendly {
    switch (this) {
      case UserType.admin:
        return 'Administrador';
      case UserType.patient:
        return 'Paciente';
      case UserType.therapist:
        return 'Terapeuta';
      case UserType.responsible:
        return 'Responsável';
    }
  }
}
