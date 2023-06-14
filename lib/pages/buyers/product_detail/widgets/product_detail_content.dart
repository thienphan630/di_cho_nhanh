import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../constraints/styles.dart';
import 'widgets_product_detail.dart';

class ProductDetailContent extends StatelessWidget {
  const ProductDetailContent({
    Key? key,
    required this.id,
    required this.name,
    required this.price,
    required this.sold,
    required this.imageURL,
    required this.stars,
    required this.addToCartTap,
    required this.buyNowTap,
    required this.document,
    required this.onFavoriteTap,
  }) : super(key: key);
  final String id;
  final String name;
  final num price;
  final num sold;
  final String imageURL;
  final num stars;
  final VoidCallback addToCartTap;
  final VoidCallback buyNowTap;
  final VoidCallback onFavoriteTap;
  final String document;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Image.memory(
            base64Decode(imageURL),
            width: size.width - 64,
            fit: BoxFit.cover,
          ),
        ),
        ProductInfor(
          id: id,
          name: name,
          price: price,
          sold: sold,
          onFavoriteTap: onFavoriteTap,
        ),
        const Delivery(),
        StoreInformation(document: document),
        ButtonContainer(
          addToCartTap: addToCartTap,
          buyNowTap: buyNowTap,
        )
      ],
    );
  }
}
