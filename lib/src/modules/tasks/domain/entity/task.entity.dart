import 'package:equatable/equatable.dart';
import 'package:psique_eleve/src/modules/appointment/domain/constants/status.enum.dart';

class TaskEntity extends Equatable {
  final String id;
  final String title;
  final String task;
  final Status status;
  final int xp;
  final DateTime createdAt;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.task,
    required this.status,
    required this.xp,
    required this.createdAt,
  });

  TaskEntity copyWith({
    String? id,
    String? title,
    String? task,
    Status? status,
    int? xp,
    DateTime? createdAt,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      task: task ?? this.task,
      status: status ?? this.status,
      xp: xp ?? this.xp,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object> get props => [
        id,
        title,
        task,
        status,
        xp,
        createdAt,
      ];
}
