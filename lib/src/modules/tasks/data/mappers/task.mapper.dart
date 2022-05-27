import 'package:psique_eleve/src/modules/appointment/domain/constants/status.enum.dart';
import 'package:psique_eleve/src/modules/tasks/domain/entity/task.entity.dart';

extension TaskMapper on TaskEntity {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'task': task,
      'status': status.name,
      'xp': xp,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  static TaskEntity? fromMap(Map<dynamic, dynamic> map) {
    if (map.isEmpty) return null;
    return TaskEntity(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      task: map['task'] ?? '',
      status: Status.values.firstWhere((e) => e.name == map['status'], orElse: () => Status.todo),
      xp: map['xp']?.toInt() ?? 0,
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
