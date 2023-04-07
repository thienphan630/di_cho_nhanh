import 'dart:convert';

class FavoriteModel {
  final String id;
  final String name;
  final String image;
  final num price;
  FavoriteModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  FavoriteModel copyWith({
    String? id,
    String? name,
    String? image,
    num? price,
  }) {
    return FavoriteModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'price': price,
    };
  }

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      price: map['price'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteModel.fromJson(String source) =>
      FavoriteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FavoriteModel(id: $id, name: $name, image: $image, price: $price)';
  }

  @override
  bool operator ==(covariant FavoriteModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.image == image &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ image.hashCode ^ price.hashCode;
  }
}
