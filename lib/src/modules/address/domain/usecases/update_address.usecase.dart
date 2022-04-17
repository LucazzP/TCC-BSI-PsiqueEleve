import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/core/use_case.abstract.dart';
import 'package:psique_eleve/src/modules/address/domain/repository/address.repository.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/address_entity.dart';

class UpdateAddressUseCase implements BaseUseCase<AddressEntity, AddressEntity> {
  final AddressRepository _repo;

  const UpdateAddressUseCase(this._repo);

  @override
  Future<Either<Failure, AddressEntity>> call(AddressEntity address) {
    return _repo.updateAddress(address);
  }
}
