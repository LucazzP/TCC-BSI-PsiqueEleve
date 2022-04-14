import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/therapists/domain/repository/therapists.repository.dart';

class GetTherapistsUseCase implements BaseUseCase<List<UserEntity>, int> {
  final TherapistsRepository _repo;

  const GetTherapistsUseCase(this._repo);

  @override
  Future<Either<Failure, List<UserEntity>>> call([int page = 0]) {
    return _repo.getTherapists(page: page);
  }
}
