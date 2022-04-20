import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/auth/domain/repository/auth.repository.dart';

class ResetPasswordUseCase implements BaseUseCase<Unit, String> {
  final AuthRepository _repo;

  const ResetPasswordUseCase(this._repo);

  @override
  Future<Either<Failure, Unit>> call(String email) {
    return _repo.resetPassword(email);
  }
}
