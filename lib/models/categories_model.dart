// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CategoriesModel {
  final String name;
  final String image;
  final Map product;
  CategoriesModel({
    required this.name,
    required this.image,
    required this.product,
  });

  CategoriesModel copyWith({
    String? name,
    String? image,
    Map? product,
  }) {
    return CategoriesModel(
      name: name ?? this.name,
      image: image ?? this.image,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'product': product,
    };
  }

  factory CategoriesModel.fromMap(Map<String, dynamic> map) {
    return CategoriesModel(
      name: map['name'] as String,
      image: map['image'] as String,
      product: Map.from(
        (map['product'] as Map),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesModel.fromJson(String source) =>
      CategoriesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CategoriesModel(name: $name, image: $image, product: $product)';

  @override
  bool operator ==(covariant CategoriesModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.image == image &&
        mapEquals(other.product, product);
  }

  @override
  int get hashCode => name.hashCode ^ image.hashCode ^ product.hashCode;
}
