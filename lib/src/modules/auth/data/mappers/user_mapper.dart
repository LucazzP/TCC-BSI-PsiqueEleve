import 'package:psique_eleve/src/modules/auth/data/mappers/role_mapper.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/role_entity.dart';
import 'package:psique_eleve/src/modules/auth/domain/entities/user_entity.dart';
import 'package:psique_eleve/src/modules/users/data/mappers/therapist_patient_relationship.mapper.dart';

import 'address_mapper.dart';

extension UserMapper on UserEntity {
  Map<String, dynamic> toMap({bool onlyUserFields = false}) {
    return {
      if (id.isNotEmpty) 'id': id,
      'full_name': fullName,
      'email': email,
      'cpf': cpf,
      'cellphone': cellphone,
      'image_url': imageUrl,
      'created_at': createdAt?.toIso8601String(),
      if (!onlyUserFields) 'xp': xp,
      if (!onlyUserFields) 'address': [address?.toMap()],
      if (!onlyUserFields) 'role_user': roles.map((e) => e.toMap()).toList(),
      if (!onlyUserFields) 'therapist': therapistRelationship?.toMap(),
    };
  }

  static UserEntity? fromMap(Map map) {
    if (map.isEmpty) return null;
    var xp = 0;
    if (map.containsKey('xp')) {
      xp = map['xp'];
    } else if (map['therapist'] != null && map['therapist']['xp'] != null) {
      xp = map['therapist']['xp'];
    }
    final user = UserEntity(
      id: map['id'] ?? '',
      password: map['password'] ?? '',
      fullName: map['full_name'] ?? '',
      email: map['email'] ?? '',
      cpf: map['cpf'] ?? '',
      cellphone: map['cellphone'] ?? '',
      imageUrl: map['image_url'] ?? '',
      address: AddressMapper.fromMap(map['address'] is List && map['address'].isNotEmpty
          ? Map.from(map['address'][0] ?? {})
          : {}),
      roles: map['role_user'] is List
          ? (map['role_user'] as List)
              .map<RoleEntity>((e) => RoleMapper.fromMap(Map.from(e ?? {})))
              .toList()
          : [],
      therapistRelationship: TherapistPatientRelationshipMapper.fromMap(map['therapist'] ?? {}),
      createdAt: map['created_at'] == null ? null : DateTime.parse(map['created_at']),
      xp: xp,
    );
    user.roles.sort((a, b) => a.type.index.compareTo(b.type.index));
    return user;
  }
}
