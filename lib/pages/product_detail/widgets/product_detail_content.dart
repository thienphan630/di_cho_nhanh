import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/utilities/get_user_id.dart';
import 'package:flutter/material.dart';

import '../../../constraints/styles.dart';
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
        ProductDetail(
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

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    Key? key,
    required this.id,
    required this.name,
    required this.price,
    required this.sold,
    required this.onFavoriteTap,
  }) : super(key: key);
  final String id;
  final String name;
  final num price;
  final num sold;
  final VoidCallback onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> favorite = FirebaseFirestore.instance
        .collection('users')
        .doc(getUserId())
        .collection('favorites')
        .where('id', isEqualTo: id);

    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: kDefaultPadding),
      padding: const EdgeInsets.symmetric(
          vertical: kDefaultPadding / 2, horizontal: kDefaultPadding),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: Offset(0, 4),
          blurRadius: 4,
          color: Color(0x40000000),
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text('$price vnđ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  )),
              const SizedBox(height: 4),
              Text(
                '$sold đã bán',
                style: const TextStyle(fontSize: 12),
              )
            ],
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: favorite.snapshots(),
            builder: (context, snapshot) {
              bool isFavorite;

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              } else {
                if (snapshot.hasData) {
                  if (snapshot.data!.size > 0) {
                    isFavorite = true;
                  } else {
                    isFavorite = false;
                  }
                  return GestureDetector(
                    onTap: onFavoriteTap,
                    child: isFavorite
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                          ),
                  );
                } else {
                  return const SizedBox();
                }
              }
            },
          )
        ],
      ),
    );
  }
}
