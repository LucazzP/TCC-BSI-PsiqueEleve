import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/modules/tasks/domain/entity/task.entity.dart';

abstract class TasksRepository {
  Future<Either<Failure, TaskEntity>> getTask(String id);
  Future<Either<Failure, List<TaskEntity>>> getTasks([String therapistPatientId = '']);
  Future<Either<Failure, TaskEntity>> createTask(TaskEntity task);
  Future<Either<Failure, TaskEntity>> updateTask(TaskEntity task);
}
