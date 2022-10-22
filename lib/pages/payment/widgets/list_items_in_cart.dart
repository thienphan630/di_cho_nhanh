import 'package:flutter/material.dart';

import '../../homepage/widget/home_widgets.dart';
import 'cart_widgets.dart';

class ListItemInCart extends StatelessWidget {
  const ListItemInCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ItemInCart(
            name: products[index]['name'].toString(),
            price: products[index]['price'] as double,
            quantity: 1);
      },
    );
  }
}
