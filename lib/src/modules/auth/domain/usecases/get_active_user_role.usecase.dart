import 'package:dartz/dartz.dart';
import 'package:flinq/flinq.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/role_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/repository/auth.repository.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_user_logged_usecase.dart';

class GetActiveUserRoleUseCase {
  final AuthRepository _repo;
  final GetUserLoggedUseCase _getUserLoggedUseCase;

  const GetActiveUserRoleUseCase(this._repo, this._getUserLoggedUseCase);

  Future<RoleEntity> call([Unit _ = unit]) async {
    final user = await _getUserLoggedUseCase();
    if (user.isLeft()) return const RoleEntity();
    final _user = user.getOrElse(() => const UserEntity());
    final selectedRoleType = await _repo.getSelectedUserRole().then((value) => value.fold(
          (failure) => UserType.patient,
          (userType) => userType,
        ));

    if (_user?.role.type == UserType.admin) {

    }

    final selectedRoleEntity = _user?.roles.firstOrNullWhere((r) => r.type == selectedRoleType);
    if (selectedRoleEntity != null) return selectedRoleEntity;
    return _user?.role ?? const RoleEntity();
  }
}
