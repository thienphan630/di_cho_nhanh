import 'dart:convert';

class ProductModal {
  final String name;
  final String image;
  final num price;
  final num quantity;
  final num sold;
  final num stars;
  final String type;
  final String seller;
  ProductModal({
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.sold,
    required this.stars,
    required this.type,
    required this.seller,
  });

  ProductModal copyWith({
    String? name,
    String? image,
    num? price,
    num? quantity,
    num? sold,
    num? stars,
    String? type,
    String? seller,
  }) {
    return ProductModal(
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      sold: sold ?? this.sold,
      stars: stars ?? this.stars,
      type: type ?? this.type,
      seller: seller ?? this.seller,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'sold': sold,
      'stars': stars,
      'type': type,
      'seller': seller,
    };
  }

  factory ProductModal.fromMap(Map<String, dynamic> map) {
    return ProductModal(
      name: map['name'] as String,
      image: map['image'] as String,
      price: map['price'] as num,
      quantity: map['quantity'] as num,
      sold: map['sold'] as num,
      stars: map['stars'] as num,
      type: map['type'] as String,
      seller: map['seller'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModal.fromJson(String source) => ProductModal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModal(name: $name, image: $image, price: $price, quantity: $quantity, sold: $sold, stars: $stars, type: $type, seller: $seller)';
  }

  @override
  bool operator ==(covariant ProductModal other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.image == image &&
      other.price == price &&
      other.quantity == quantity &&
      other.sold == sold &&
      other.stars == stars &&
      other.type == type &&
      other.seller == seller;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      image.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      sold.hashCode ^
      stars.hashCode ^
      type.hashCode ^
      seller.hashCode;
  }
}
