import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../constraints/styles.dart';

class Product extends StatelessWidget {
  const Product(
      {super.key,
      required this.name,
      required this.image,
      required this.price,
      required this.onSelectedTap,
      required this.onDeleteTap});
  final String name;
  final String image;
  final VoidCallback onSelectedTap;
  final VoidCallback onDeleteTap;

  final num price;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelectedTap,
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        decoration: const BoxDecoration(
          color: Color(0xFF84CBFF),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            child: Image.memory(
              base64Decode(image),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
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
                        fontSize: 14,
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
              GestureDetector(
                onTap: onDeleteTap,
                child: const Icon(
                  Icons.delete_forever,
                  color: Color(0xFF58A700),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
