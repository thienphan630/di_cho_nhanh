import 'package:flutter/material.dart';

import '../../../constraints/styles.dart';
import '../../homepage/widget/home_widgets.dart';

Widget favoriteItem(index) {
  return Container(
    height: 200,
    margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
    padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
    decoration: const BoxDecoration(
      color: Color(0xFF84CBFF),
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      const CircleAvatar(
        maxRadius: 50,
        backgroundImage: AssetImage('assets/images/meat.png'),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categories[index]['name'].toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                '${categories[index]["price"]} đ/Kg',
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
