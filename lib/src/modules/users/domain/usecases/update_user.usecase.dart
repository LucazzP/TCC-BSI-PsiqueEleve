import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/address/domain/usecases/update_address.usecase.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/address_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/repository/auth.repository.dart';
import 'package:psique_eleve/src/modules/auth/domain/usecases/get_active_user_role.usecase.dart';
import 'package:psique_eleve/src/modules/users/domain/entities/therapist_patient_relationship.entity.dart';
import 'package:psique_eleve/src/modules/users/domain/repository/users.repository.dart';

class UpdateUserParams {
  final UserEntity user;
  final List<UserType> userTypes;
  final bool isProfilePage;
  final TherapistPatientRelationshipEntity therapistPatientRelationship;
  final List<TherapistPatientRelationshipEntity> responsiblesRelationship;

  const UpdateUserParams({
    required this.user,
    required this.userTypes,
    required this.isProfilePage,
    required this.therapistPatientRelationship,
    this.responsiblesRelationship = const [],
  });
}

class UpdateUserUseCase implements BaseUseCase<UserEntity, UpdateUserParams> {
  final UsersRepository _repo;
  final UpdateAddressUseCase _updateAddressUseCase;
  final AuthRepository _authRepository;
  final GetActiveUserRoleUseCase _getActiveUserRoleUseCase;

  const UpdateUserUseCase(
    this._repo,
    this._updateAddressUseCase,
    this._authRepository,
    this._getActiveUserRoleUseCase,
  );

  @override
  Future<Either<Failure, UserEntity>> call(UpdateUserParams params) async {
    final _user = params.user;
    final _address = _user.address;
    final _roles = await _repo.getRoles(params.userTypes);

    return _roles.fold((l) => Left(l), (roles) async {
      final _userResult = await _repo.updateUser(
        _user,
        roles,
        (await _getActiveUserRoleUseCase()).type,
        params.therapistPatientRelationship,
        responsiblesRelationship: params.responsiblesRelationship,
      );
      Either<Failure, AddressEntity> _addressResult = const Right(AddressEntity());

      return _userResult.fold((l) => Left(l), (user) async {
        if (_address != null && _address.isComplete()) {
          _addressResult = await _updateAddressUseCase.call(_address.copyWith(userId: user.id));
        }

        await _authRepository.resetLocalUser();
        await _authRepository.getUserLogged();

        return _addressResult.fold(
          (l) => Left(l),
          (address) => Right(user.copyWith(address: address)),
        );
      });
    });
  }
}
