import 'package:flutter/material.dart';

import 'categorise_widgets.dart';

class BannerCategories extends StatelessWidget {
  const BannerCategories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(38),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 5.5,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: GridView.builder(
        itemCount: 5,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            mainAxisSpacing: 2,
            mainAxisExtent: 68),
        itemBuilder: (context, index) {
          return const ItemCategoriesBanner(name: 'Thịt');
        },
      ),
    );
  }
}
