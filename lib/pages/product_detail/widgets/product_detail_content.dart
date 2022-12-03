import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../constraints/styles.dart';
import 'widgets_product_detail.dart';

class ProductDetailContent extends StatelessWidget {
  const ProductDetailContent({
    Key? key,
    required this.name,
    required this.price,
    required this.sold,
    required this.imageURL,
    required this.stars,
    required this.addToCartTap,
    required this.buyNowTap,
  }) : super(key: key);
  final String name;
  final num price;
  final num sold;
  final String imageURL;
  final num stars;
  final VoidCallback addToCartTap;
  final VoidCallback buyNowTap;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Image.memory(
            base64Decode(imageURL),
            width: size.width - 32,
            fit: BoxFit.cover,
          ),
        ),
        ProductDetail(name: name, price: price, sold: sold),
        const Delivery(),
        const StoreInformation(),
        ButtonContainer(
          addToCartTap: addToCartTap,
          buyNowTap: buyNowTap,
        )
      ],
    );
  }
}

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    Key? key,
    required this.name,
    required this.price,
    required this.sold,
  }) : super(key: key);

  final String name;
  final num price;
  final num sold;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: Offset(0, 4),
          blurRadius: 4,
          color: Color(0x40000000),
        )
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text('đ$price',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              )),
          Text(
            '$sold đã bán',
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
