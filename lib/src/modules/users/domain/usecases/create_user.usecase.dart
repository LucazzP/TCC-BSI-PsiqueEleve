import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/address/domain/usecases/create_address.usecase.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/address_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_active_user_role.usecase.dart';
import 'package:psique_eleve/src/modules/users/domain/repository/users.repository.dart';

class CreateUserParams {
  final UserEntity user;
  final List<UserType> userTypes;

  const CreateUserParams({
    required this.user,
    required this.userTypes,
  });
}

class CreateUserUseCase implements BaseUseCase<UserEntity, CreateUserParams> {
  final UsersRepository _repo;
  final CreateAddressUseCase _createAddressUseCase;
  final GetActiveUserRoleUseCase _getActiveUserRoleUseCase;

  const CreateUserUseCase(this._repo, this._createAddressUseCase, this._getActiveUserRoleUseCase);

  @override
  Future<Either<Failure, UserEntity>> call(CreateUserParams params) async {
    final _user = params.user;
    final address = _user.address?.copyWith(id: '');
    final _activeUserRole = await _getActiveUserRoleUseCase();

    final _roles = await _repo.getRoles(params.userTypes);

    return _roles.fold((l) => Left(l), (roles) async {
      final _userResult = await _repo.createUser(_user, roles, _activeUserRole.type);
      Either<Failure, AddressEntity> _addressResult = const Right(AddressEntity());

      return _userResult.fold((l) => Left(l), (user) async {
        if (address != null && address.isComplete()) {
          _addressResult = await _createAddressUseCase.call(address.copyWith(userId: user.id));
        }

        return _addressResult.fold(
          (l) => Left(l),
          (address) => Right(user.copyWith(address: address)),
        );
      });
    });
  }
}
