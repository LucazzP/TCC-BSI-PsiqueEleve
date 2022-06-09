import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_active_user_role.usecase.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:psique_eleve/src/modules/users/domain/repository/users.repository.dart';

class GetPatientsParams {
  final int page;
  final bool callOnlyPatients;

  const GetPatientsParams({
    this.page = 0,
    this.callOnlyPatients = false,
  });
}

class GetPatientsUseCase implements BaseUseCase<List<UserEntity>, GetPatientsParams> {
  final UsersRepository _repo;
  final GetUserLoggedUseCase _getUserLoggedUseCase;
  final GetActiveUserRoleUseCase _getActiveUserRoleUseCase;

  const GetPatientsUseCase(this._repo, this._getUserLoggedUseCase, this._getActiveUserRoleUseCase);

  @override
  Future<Either<Failure, List<UserEntity>>> call(GetPatientsParams params) async {
    final user = await _getUserLoggedUseCase();
    if (user.isLeft()) return user.map((r) => []);
    return _repo.getUsers(
      page: params.page,
      userTypes: [UserType.patient, if (!params.callOnlyPatients) UserType.responsible],
      activeUserRole: (await _getActiveUserRoleUseCase()).type,
      loggedUserId: user.getOrElse(() => const UserEntity())?.id ?? '',
    );
  }
}
