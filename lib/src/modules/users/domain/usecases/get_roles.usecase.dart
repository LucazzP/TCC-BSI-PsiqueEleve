import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/role_entity.dart';
import 'package:psique_eleve/src/modules/users/domain/repository/users.repository.dart';

class GetRolesUseCase implements BaseUseCase<List<RoleEntity>, Unit> {
  final UsersRepository _repo;

  const GetRolesUseCase(this._repo);

  @override
  Future<Either<Failure, List<RoleEntity>>> call([Unit _ = unit]) {
    return _repo.getRoles(UserType.values);
  }
}
