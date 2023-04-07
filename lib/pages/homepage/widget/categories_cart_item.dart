import 'dart:convert';

import 'package:flutter/material.dart';

class CategoriesCartItem extends StatelessWidget {
  const CategoriesCartItem({
    Key? key,
    required this.name,
    required this.onTap,
    required this.imageURL,
  }) : super(key: key);
  final String name;
  final String imageURL;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        width: 120,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(132, 203, 255, 0.8),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  color: Color.fromRGBO(0, 0, 0, 0.25))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              child: Image.memory(
                base64Decode(imageURL),
                width: 86,
                height: 86,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
