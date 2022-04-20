import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/auth/domain/repository/auth.repository.dart';

class ChangePasswordUseCase implements BaseUseCase<Unit, String> {
  final AuthRepository _repo;

  const ChangePasswordUseCase(this._repo);

  @override
  Future<Either<Failure, Unit>> call(String newPassword) {
    return _repo.changePassword(newPassword);
  }
}
