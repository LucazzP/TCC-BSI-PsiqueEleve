import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String id;
  final String street;
  final String number;
  final String complement;
  final String district;
  final String zipCode;
  final String city;
  final String state;
  final String country;
  final String userId;

  const AddressEntity({
    this.id = '',
    this.street = '',
    this.number = '',
    this.complement = '',
    this.zipCode = '',
    this.city = '',
    this.state = '',
    this.country = '',
    this.district = '',
    this.userId = '',
  });

  bool isComplete() {
    return street.isNotEmpty &&
        number.isNotEmpty &&
        district.isNotEmpty &&
        city.isNotEmpty &&
        state.isNotEmpty &&
        zipCode.isNotEmpty &&
        country.isNotEmpty;
  }

  AddressEntity copyWith({
    String? id,
    String? street,
    String? number,
    String? complement,
    String? zipCode,
    String? city,
    String? state,
    String? country,
    String? district,
    String? userId,
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
      district: district ?? this.district,
      userId: userId ?? this.userId,
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
      district,
      userId,
    ];
  }
}
