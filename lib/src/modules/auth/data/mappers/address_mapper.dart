import 'package:psique_eleve/src/modules/auth/domain/entities/address_entity.dart';

extension AddressMapper on AddressEntity {
  Map<String, dynamic> toMap() {
    return {
      if (id.isNotEmpty) 'id': id,
      'street': street,
      'number': number,
      'complement': complement,
      'district': district,
      'zip_code': zipCode,
      'city': city,
      'state': state,
      'country': country,
      'user_id': userId,
    };
  }

  static AddressEntity? fromMap(Map map) {
    if (map.isEmpty) return null;
    return AddressEntity(
      id: map['id'] ?? '',
      street: map['street'] ?? '',
      number: map['number'] ?? '',
      complement: map['complement'] ?? '',
      zipCode: map['zip_code'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      country: map['country'] ?? '',
      district: map['district'] ?? '',
      userId: map['user_id'] ?? '',
    );
  }
}
