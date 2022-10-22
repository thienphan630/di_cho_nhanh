import 'package:di_cho_nhanh/constraints/styles.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_widget.dart';
import 'widgets/list_item_favorite.dart';

class FavoriteItems extends StatelessWidget {
  const FavoriteItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppBar('Hàng hóa'),
      backgroundColor: const Color(0xFFF0EFEF),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 2 * kDefaultPadding),
        child: ListItem(),
      ),
    );
  }
}
