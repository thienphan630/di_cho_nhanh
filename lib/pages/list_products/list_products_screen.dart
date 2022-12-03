import 'package:di_cho_nhanh/models/agruments/product_type.dart';
import 'package:flutter/material.dart';

import '../../constraints/styles.dart';
import '../../widgets/app_widget.dart';
import 'widgets/list_item.dart';

class ListProducts extends StatelessWidget {
  const ListProducts({Key? key, required this.type}) : super(key: key);
  final ProductType type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppBar(categoriName(type)),
      backgroundColor: const Color(0xFFF0EFEF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2 * kDefaultPadding),
        child: ListItems(type: type),
      ),
    );
  }
}
