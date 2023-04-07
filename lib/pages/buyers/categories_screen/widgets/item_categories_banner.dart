import 'dart:convert';

import 'package:flutter/material.dart';

class ItemCategoriesBanner extends StatelessWidget {
  const ItemCategoriesBanner({
    Key? key,
    required this.name,
    required this.image,
    required this.onTap,
  }) : super(key: key);
  final String name;
  final String image;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.height / 14,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(1, 1),
                    blurRadius: 2,
                    // crossAxisSpacing: 20,
                    spreadRadius: 1,
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: Image.memory(
                  base64Decode(image),
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
