import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String id;
  final String street;
  final String number;
  final String complement;
  final String zipCode;
  final String city;
  final String state;
  final String country;

  const AddressEntity({
    this.id = '',
    this.street = '',
    this.number = '',
    this.complement = '',
    this.zipCode = '',
    this.city = '',
    this.state = '',
    this.country = '',
  });

  AddressEntity copyWith({
    String? id,
    String? street,
    String? number,
    String? complement,
    String? zipCode,
    String? city,
    String? state,
    String? country,
  }) {
    return AddressEntity(
      id: id ?? this.id,
      street: street ?? this.street,
      number: number ?? this.number,
      complement: complement ?? this.complement,
      zipCode: zipCode ?? this.zipCode,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      street,
      number,
      complement,
      zipCode,
      city,
      state,
      country,
    ];
  }
}
