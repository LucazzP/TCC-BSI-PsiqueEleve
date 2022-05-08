import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/tasks/domain/entity/task.entity.dart';
import 'package:psique_eleve/src/modules/tasks/domain/repository/tasks.repository.dart';

class GetTaskUseCase implements BaseUseCase<TaskEntity, String> {
  final TasksRepository _repo;

  const GetTaskUseCase(this._repo);

  @override
  Future<Either<Failure, TaskEntity>> call(String taskId) {
    return _repo.getTask(taskId);
  }
}
