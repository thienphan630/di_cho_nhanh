// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SellerModel {
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String storeName;
  SellerModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.storeName,
  });

  SellerModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? address,
    String? storeName,
  }) {
    return SellerModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      address: address ?? this.address,
      storeName: storeName ?? this.storeName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'address': address,
      'storeName': storeName,
    };
  }

  factory SellerModel.fromMap(Map<String, dynamic> map) {
    return SellerModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      storeName: map['storeName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerModel.fromJson(String source) =>
      SellerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SellerModel(firstName: $firstName, lastName: $lastName, email: $email, address: $address, storeName: $storeName)';
  }

  @override
  bool operator ==(covariant SellerModel other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.address == address &&
        other.storeName == storeName;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        address.hashCode ^
        storeName.hashCode;
  }
}
