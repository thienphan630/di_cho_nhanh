import 'package:flutter/material.dart';

import '../../../widgets/data.dart';
import 'item_favorite.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 20, crossAxisCount: 2, childAspectRatio: 2 / 3),
      itemBuilder: (context, index) {
        return favoriteItem(index);
      },
    );
  }
}
