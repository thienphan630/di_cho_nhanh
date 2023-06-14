import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constraints/styles.dart';
import '../../../../utilities/get_user_id.dart';

class ProductInfor extends StatelessWidget {
  const ProductInfor({
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
              Text(NumberFormat('###,000').format(price),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  )),
              const SizedBox(height: 4),
              Text(
                'Đã bán $sold',
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
