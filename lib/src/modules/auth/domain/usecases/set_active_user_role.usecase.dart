import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/repository/auth.repository.dart';

class SetActiveUserRoleUseCase extends BaseUseCase<Unit, UserType> {
  final AuthRepository _repo;

  const SetActiveUserRoleUseCase(this._repo);

  @override
  Future<Either<Failure, Unit>> call(UserType param) {
    return _repo.setSelectedUserRole(param);
  }
}
