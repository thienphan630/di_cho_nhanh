import 'dart:convert';

import 'package:di_cho_nhanh/constraints/color.dart';
import 'package:di_cho_nhanh/constraints/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
            width: size.width / 3.6,
            height: 140,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: Color(0xFF84CBFF),
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              child: Image.memory(
                base64Decode(imageURL),
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: size.width * 3 / 5,
            height: 100,
            decoration: const BoxDecoration(
                color: AppColor.kWhiteColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: kDefaultPadding / 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                        Text(NumberFormat('###,000').format(price),
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: onMinusTap,
                        child: const Text(
                          '- ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        quantity.toStringAsFixed(1),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: onPlusTap,
                        child: const Text(
                          ' +',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                      GestureDetector(
                        onTap: onDeleteTap,
                        child: const Icon(
                          Icons.delete,
                          size: 20,
                          color: Colors.red,
                        ),
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
