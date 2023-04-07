import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../config/route_path.dart';
import '../../../../models/agruments/product_type.dart';
import 'categories_widgets.dart';

class BannerCategories extends StatelessWidget {
  const BannerCategories({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var categories = FirebaseFirestore.instance.collection('Categories');
    ProductType type = ProductType.undefine;
    return Container(
        margin: const EdgeInsets.all(38),
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 5.5,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: categories.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return GridView.builder(
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  mainAxisSpacing: 2,
                  mainAxisExtent: 68,
                ),
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index];
                  return ItemCategoriesBanner(
                    name: '${data.get('name')}',
                    image: '${data.get('image')}',
                    onTap: () {
                      type = toProductType(data.get('type'));
                      Navigator.pushNamed(context, RoutePath.listProduct,
                          arguments: type);
                    },
                  );
                },
              );
            } else {
              return const Text('No data');
            }
          },
        )

        // GridView.builder(
        //   itemCount: 5,
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 3,
        //     childAspectRatio: 1,
        //     mainAxisSpacing: 2,
        //     mainAxisExtent: 68,
        //   ),
        //   itemBuilder: (context, index) {
        //     return const ItemCategoriesBanner(name: 'Thịt');
        //   },
        // ),
        );
  }
}
