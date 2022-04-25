import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/users/domain/repository/users.repository.dart';

class GetUserUseCase implements BaseUseCase<UserEntity, String> {
  final UsersRepository _repo;

  const GetUserUseCase(this._repo);

  @override
  Future<Either<Failure, UserEntity>> call(String userId) {
    return _repo.getUser(userId);
  }
}
