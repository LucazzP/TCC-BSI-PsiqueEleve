import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';

import 'address_mapper.dart';

extension UserMapper on UserEntity {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'cpf': cpf,
      'cellphone': cellphone,
      'address': address.toMap(),
    };
  }

  static UserEntity fromMap(Map map) {
    return UserEntity(
      id: map['id'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      cpf: map['cpf'] ?? '',
      cellphone: map['cellphone'] ?? '',
      address: AddressMapper.fromMap(map['address']),
    );
  }
}