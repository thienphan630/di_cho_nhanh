import 'dart:convert';

class AddToCart {
  String id;
  String name;
  String image;
  num price;
  num quantity;
  AddToCart({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  AddToCart copyWith({
    String? id,
    String? name,
    String? image,
    num? price,
    num? quantity,
  }) {
    return AddToCart(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }

  factory AddToCart.fromMap(Map<String, dynamic> map) {
    return AddToCart(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      price: map['price'] as num,
      quantity: map['quantity'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddToCart.fromJson(String source) => AddToCart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddToCart(id: $id, name: $name, image: $image, price: $price, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant AddToCart other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.image == image &&
      other.price == price &&
      other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      image.hashCode ^
      price.hashCode ^
      quantity.hashCode;
  }
}
