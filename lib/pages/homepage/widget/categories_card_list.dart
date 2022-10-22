import 'package:flutter/material.dart';

import 'home_widgets.dart';

class CategoriesCardList extends StatelessWidget {
  const CategoriesCardList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return CategoriesCartItem(
            name: products[index]['name'].toString(),
            onTap: () {},
          );
        });
  }
}
