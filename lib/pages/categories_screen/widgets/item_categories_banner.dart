import 'package:flutter/material.dart';

class ItemCategoriesBanner extends StatelessWidget {
  const ItemCategoriesBanner({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/rau.png'),
            ),
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
