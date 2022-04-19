import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/auth/domain/repository/auth.repository.dart';

class LogoutUseCase implements BaseUseCase<Unit, Unit> {
  final AuthRepository _repo;

  const LogoutUseCase(this._repo);

  @override
  Future<Either<Failure, Unit>> call([Unit param = unit]) {
    return _repo.logout();
  }
}
