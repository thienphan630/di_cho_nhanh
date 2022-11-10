import 'package:flutter/material.dart';

import '../../../constraints/styles.dart';

Widget favoriteItem(String name, String imageURL, num price) {
  return Container(
    height: 200,
    margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
    padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
    decoration: const BoxDecoration(
      color: Color(0xFF84CBFF),
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      CircleAvatar(
          maxRadius: 50,
          backgroundImage: NetworkImage(
              'https://drive.google.com/uc?export=view&id=$imageURL')),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                '$price đ/Kg',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          const Icon(
            Icons.shopping_cart_rounded,
            color: Color(0xFF58A700),
          )
        ],
      ),
    ]),
  );
}
