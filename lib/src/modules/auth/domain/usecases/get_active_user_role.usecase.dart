import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/repository/auth.repository.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_user_logged_usecase.dart';

class GetActiveUserRoleUseCase {
  final AuthRepository _repo;
  final GetUserLoggedUseCase _getUserLoggedUseCase;

  const GetActiveUserRoleUseCase(this._repo, this._getUserLoggedUseCase);

  Future<UserType> call([Unit _ = unit]) async {
    final user = await _getUserLoggedUseCase();
    if (user.isLeft()) return UserType.patient;
    final _user = user.getOrElse(() => const UserEntity());
    final res = await _repo.getSelectedUserRole().then((value) => value.fold(
          (failure) => UserType.patient,
          (userType) => userType,
        ));
    if (_user?.role.type == UserType.admin ||
        (_user?.roles.map((e) => e.type).contains(res) ?? false)) return res;
    return _user?.role.type ?? UserType.patient;
  }
}
