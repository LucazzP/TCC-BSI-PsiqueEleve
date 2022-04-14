import 'package:psique_eleve/src/modules/auth/domain/entities/address_entity.dart';

extension AddressMapper on AddressEntity {


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'street': street,
      'number': number,
      'complement': complement,
      'zipCode': zipCode,
      'city': city,
      'state': state,
      'country': country,
    };
  }

  static AddressEntity? fromMap(Map map) {
    if (map.isEmpty) return null;
    return AddressEntity(
      id: map['id'] ?? '',
      street: map['street'] ?? '',
      number: map['number'] ?? '',
      complement: map['complement'] ?? '',
      zipCode: map['zipCode'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      country: map['country'] ?? '',
    );
  }
}