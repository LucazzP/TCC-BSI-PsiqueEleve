import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/tasks/domain/entity/task.entity.dart';
import 'package:psique_eleve/src/modules/tasks/domain/repository/tasks.repository.dart';

class GetTasksUseCase implements BaseUseCase<List<TaskEntity>, Unit> {
  final TasksRepository _repo;

  const GetTasksUseCase(this._repo);

  @override
  Future<Either<Failure, List<TaskEntity>>> call([Unit unit = unit]) {
    return _repo.getTasks();
  }
}
