enum Status {
  todo,
  completed,
  overdue,
  completedOverdue,
}

extension StatusExtension on Status {
  String get friendlyName {
    switch (this) {
      case Status.todo:
        return 'A fazer';
      case Status.completed:
        return 'Realizado';
      case Status.overdue:
        return 'Atrasado (não realizado)';
      case Status.completedOverdue:
        return 'Realizado com atraso';
    }
  }
}
