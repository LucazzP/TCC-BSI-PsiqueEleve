import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/data/utils/call_either.dart';
import 'package:psique_eleve/src/extensions/iterable.ext.dart';
import 'package:psique_eleve/src/extensions/map.ext.dart';
import 'package:psique_eleve/src/modules/tasks/data/mappers/task.mapper.dart';
import 'package:psique_eleve/src/modules/tasks/domain/entity/task.entity.dart';
import '../datasource/remote/tasks_remote.datasource.dart';
import '../../domain/repository/tasks.repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TasksRemoteDataSource _dataSource;

  const TasksRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, TaskEntity>> createTask(TaskEntity task) {
    return callEither<TaskEntity, Map>(
      () => _dataSource.createTask(task.toMap()),
      processResponse: (res) async => res.toEntityEither(TaskMapper.fromMap),
    );
  }

  @override
  Future<Either<Failure, TaskEntity>> getTask(String id) {
    return callEither<TaskEntity, Map>(
      () => _dataSource.getTask(id),
      processResponse: (res) async => res.toEntityEither(TaskMapper.fromMap),
    );
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks() {
    return callEither<List<TaskEntity>, List<Map>>(
      () => _dataSource.getTasks(),
      processResponse: (res) async => Right(res.map(TaskMapper.fromMap).whereNotNull().toList()),
    );
  }

  @override
  Future<Either<Failure, TaskEntity>> updateTask(TaskEntity task) {
    return callEither<TaskEntity, Map>(
      () => _dataSource.updateTask(task.toMap()),
      processResponse: (res) async => res.toEntityEither(TaskMapper.fromMap),
    );
  }
}
