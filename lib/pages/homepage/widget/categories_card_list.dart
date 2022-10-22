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
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoriesCartItem(
            name: categories[index]['name'].toString(),
            onTap: () {},
          );
        });
  }
}
