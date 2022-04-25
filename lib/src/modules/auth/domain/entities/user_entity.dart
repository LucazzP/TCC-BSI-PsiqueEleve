import 'package:equatable/equatable.dart';
import 'package:flinq/flinq.dart';
import 'package:psique_eleve/src/modules/auth/domain/constants/user_type.dart';
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
  final UserEntity? therapist;
  // Will be stored the new temp password when create a new user
  final String password;

  const UserEntity({
    this.id = '',
    this.fullName = '',
    this.email = '',
    this.cpf = '',
    this.cellphone = '',
    this.imageUrl = '',
    this.password = '',
    this.roles = const [],
    this.address,
    this.therapist,
  });

  RoleEntity get role {
    final bestRole = roles.firstOrNull;
    if(bestRole == null) {
      return const RoleEntity(type: UserType.patient, name: 'patient');
    }
    return RoleEntity(
      id: bestRole.id,
      name: bestRole.name,
      type: bestRole.type,
      canManageTherapists: roles.any((role) => role.canManageTherapists),
      canManagePatients: roles.any((role) => role.canManagePatients),
      canManageResponsibles: roles.any((role) => role.canManageResponsibles),
      canManagePatientTherapistRelationships:
          roles.any((role) => role.canManagePatientTherapistRelationships),
      canManageAppointments: roles.any((role) => role.canManageAppointments),
      canManageTasks: roles.any((role) => role.canManageTasks),
      canManageAchivements: roles.any((role) => role.canManageAchivements),
      canManageRewards: roles.any((role) => role.canManageRewards),
    );
  }

  UserEntity copyWith({
    String? id,
    String? fullName,
    String? email,
    String? cpf,
    String? cellphone,
    String? imageUrl,
    AddressEntity? address,
    List<RoleEntity>? roles,
    String? password,
    UserEntity? therapist,
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
      password: password ?? this.password,
      therapist: therapist ?? this.therapist,
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
      password,
      therapist,
    ];
  }
}
