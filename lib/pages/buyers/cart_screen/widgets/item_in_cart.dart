import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../constraints/styles.dart';

class ItemInCart extends StatelessWidget {
  const ItemInCart({
    super.key,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageURL,
    required this.onMinusTap,
    required this.onPlusTap,
    required this.onDeleteTap,
  });
  final String name;
  final String imageURL;
  final num price;
  final num quantity;
  final VoidCallback onMinusTap;
  final VoidCallback onPlusTap;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        children: [
          Container(
            width: size.width / 3.5,
            height: 160,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: Color(0xFF84CBFF),
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              child: Image.memory(
                base64Decode(imageURL),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: size.width * 3 / 5,
            height: 100,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                      Text('$price đ/Kg',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: onMinusTap,
                        child: const Text(
                          '- ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        quantity.toStringAsFixed(1),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: onPlusTap,
                        child: const Text(
                          ' +',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      GestureDetector(
                        onTap: onDeleteTap,
                        child: const Icon(Icons.delete, size: 16),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
