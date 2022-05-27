import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_active_user_role.usecase.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:psique_eleve/src/modules/users/domain/repository/users.repository.dart';

class GetPatientsUseCase implements BaseUseCase<List<UserEntity>, int> {
  final UsersRepository _repo;
  final GetUserLoggedUseCase _getUserLoggedUseCase;
  final GetActiveUserRoleUseCase _getActiveUserRoleUseCase;

  const GetPatientsUseCase(this._repo, this._getUserLoggedUseCase, this._getActiveUserRoleUseCase);

  @override
  Future<Either<Failure, List<UserEntity>>> call([int page = 0]) async {
    final user = await _getUserLoggedUseCase();
    if (user.isLeft()) return user.map((r) => []);
    return _repo.getUsers(
      page: page,
      userTypes: [UserType.patient, UserType.responsible],
      activeUserRole: (await _getActiveUserRoleUseCase()).type,
      loggedUserId: user.getOrElse(() => const UserEntity())?.id ?? '',
    );
  }
}
