import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/users/domain/repository/users.repository.dart';

class GetPatientsUseCase implements BaseUseCase<List<UserEntity>, int> {
  final UsersRepository _repo;

  const GetPatientsUseCase(this._repo);

  @override
  Future<Either<Failure, List<UserEntity>>> call([int page = 0]) {
    return _repo.getUsers(page: page, userTypes: [UserType.patient, UserType.responsible]);
  }
}
