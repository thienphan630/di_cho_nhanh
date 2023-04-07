import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/favorite_provider.dart';

class TopSearchItem extends StatefulWidget {
  const TopSearchItem({
    Key? key,
    required this.name,
    required this.imageURL,
    required this.onTap,
    required this.onFavoriteTap,
  }) : super(key: key);
  final String name;
  final String imageURL;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  @override
  State<TopSearchItem> createState() => _TopSearchItemState();
}

class _TopSearchItemState extends State<TopSearchItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
            width: 120,
            height: 110,
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: const [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(
                          '5.0',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ]),
                      GestureDetector(
                        onTap: widget.onFavoriteTap,
                        child: Consumer<FavoriteProvider>(
                            builder: (_, favorite, __) {
                          return const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 16,
                          );
                        }),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            child: Image.memory(
              base64Decode(widget.imageURL),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
