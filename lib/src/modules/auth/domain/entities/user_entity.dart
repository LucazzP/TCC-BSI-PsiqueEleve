import 'package:equatable/equatable.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/address_entity.dart';

class UserEntity extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String cpf;
  final String cellphone;
  final AddressEntity address;

  const UserEntity({
    this.id = '',
    this.fullName = '',
    this.email = '',
    this.cpf = '',
    this.cellphone = '',
    required this.address,
  });

  UserEntity copyWith({
    String? id,
    String? fullName,
    String? email,
    String? cpf,
    String? cellphone,
    AddressEntity? address,
  }) {
    return UserEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      cellphone: cellphone ?? this.cellphone,
      address: address ?? this.address,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      fullName,
      email,
      cpf,
      cellphone,
      address,
    ];
  }
}
