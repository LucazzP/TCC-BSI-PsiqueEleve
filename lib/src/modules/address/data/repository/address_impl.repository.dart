import 'package:dartz/dartz.dart';
import 'package:psique_eleve/src/core/failures.dart';
import 'package:psique_eleve/src/data/utils/call_either.dart';
import 'package:psique_eleve/src/extensions/map.ext.dart';
import 'package:psique_eleve/src/modules/auth/data/mappers/address_mapper.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/address_entity.dart';
import '../datasource/address.datasource.dart';
import '../../domain/repository/address.repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressDataSource _dataSource;

  const AddressRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, AddressEntity>> createAddress(AddressEntity address) {
    return callEither<AddressEntity, Map>(
      () => _dataSource.createAddress(address.toMap()),
      processResponse: (res) async => res.toEntityEither(AddressMapper.fromMap),
    );
  }

  @override
  Future<Either<Failure, AddressEntity>> updateAddress(AddressEntity address) {
    return callEither<AddressEntity, Map>(
      () => _dataSource.updateAddress(address.toMap()),
      processResponse: (res) async => res.toEntityEither(AddressMapper.fromMap),
    );
  }
}
