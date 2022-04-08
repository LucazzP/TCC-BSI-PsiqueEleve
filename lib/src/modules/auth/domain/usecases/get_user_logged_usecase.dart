import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/repository/auth.repository.dart';

class GetUserLoggedUseCase implements BaseUseCase<UserEntity, Unit> {
  final AuthRepository _repo;

  const GetUserLoggedUseCase(this._repo);

  @override
  Future<Either<Failure, UserEntity>> call([Unit param = unit]) {
    return _repo.getUserLogged();
  }
}
