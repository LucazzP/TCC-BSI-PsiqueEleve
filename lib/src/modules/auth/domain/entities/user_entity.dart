import 'package:equatable/equatable.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/address_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/role_entity.dart';

class UserEntity extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String cpf;
  final String cellphone;
  final String imageUrl;
  final AddressEntity? address;
  final List<RoleEntity> roles;

  const UserEntity({
    this.id = '',
    this.fullName = '',
    this.email = '',
    this.cpf = '',
    this.cellphone = '',
    this.imageUrl = '',
    required this.address,
    required this.roles,
  });

  UserEntity copyWith({
    String? id,
    String? fullName,
    String? email,
    String? cpf,
    String? cellphone,
    String? imageUrl,
    AddressEntity? address,
    List<RoleEntity>? roles,
  }) {
    return UserEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      cellphone: cellphone ?? this.cellphone,
      imageUrl: imageUrl ?? this.imageUrl,
      address: address ?? this.address,
      roles: roles ?? this.roles,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      fullName,
      email,
      cpf,
      cellphone,
      address,
      roles,
      imageUrl,
    ];
  }
}
