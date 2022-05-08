import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/tasks/domain/entity/task.entity.dart';
import 'package:psique_eleve/src/modules/tasks/domain/repository/tasks.repository.dart';

class UpdateTaskUseCase implements BaseUseCase<TaskEntity, TaskEntity> {
  final TasksRepository _repo;

  const UpdateTaskUseCase(this._repo);

  @override
  Future<Either<Failure, TaskEntity>> call(TaskEntity task) {
    return _repo.updateTask(task);
  }
}
