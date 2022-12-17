import 'dart:convert';

class SellerModel {
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String storeName;
  final String phoneNumber;
  SellerModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.storeName,
    required this.phoneNumber,
  });
  

  SellerModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? address,
    String? storeName,
    String? phoneNumber,
  }) {
    return SellerModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      address: address ?? this.address,
      storeName: storeName ?? this.storeName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'address': address,
      'storeName': storeName,
      'phoneNumber': phoneNumber,
    };
  }

  factory SellerModel.fromMap(Map<String, dynamic> map) {
    return SellerModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      storeName: map['storeName'] as String,
      phoneNumber: map['phoneNumber'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerModel.fromJson(String source) => SellerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SellerModel(firstName: $firstName, lastName: $lastName, email: $email, address: $address, storeName: $storeName, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(covariant SellerModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.email == email &&
      other.address == address &&
      other.storeName == storeName &&
      other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
      lastName.hashCode ^
      email.hashCode ^
      address.hashCode ^
      storeName.hashCode ^
      phoneNumber.hashCode;
  }
}
