import 'dart:convert';

class FavoriteModel {
  final String name;
  final String image;
  final double price;
  FavoriteModel({
    required this.name,
    required this.image,
    required this.price,
  });

  FavoriteModel copyWith({
    String? name,
    String? image,
    double? price,
  }) {
    return FavoriteModel(
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'price': price,
    };
  }

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      name: map['name'] as String,
      image: map['image'] as String,
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteModel.fromJson(String source) =>
      FavoriteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FavoriteModel(name: $name, image: $image, price: $price)';

  @override
  bool operator ==(covariant FavoriteModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.image == image && other.price == price;
  }

  @override
  int get hashCode => name.hashCode ^ image.hashCode ^ price.hashCode;
}
