import 'package:psique_eleve/src/modules/appointment/domain/constants/status.enum.dart';
import 'package:psique_eleve/src/modules/tasks/domain/entity/task.entity.dart';

extension TaskMapper on TaskEntity {
  Map<String, dynamic> toMap() {
    return {
      if (id.isNotEmpty) 'id': id,
      'task': task,
      'status': status.name,
      'xp': xp,
      // 'createdAt': createdAt.toIso8601String(),
    };
  }

  static TaskEntity? fromMap(Map<dynamic, dynamic> map) {
    if (map.isEmpty) return null;
    return TaskEntity(
      id: map['id'] ?? '',
      task: map['task'] ?? '',
      status: Status.values.firstWhere((e) => e.name == map['status'], orElse: () => Status.todo),
      xp: map['xp']?.toInt() ?? 0,
      createdAt: map['created_at'] == null ? DateTime.now() : DateTime.parse(map['created_at']),
    );
  }
}
