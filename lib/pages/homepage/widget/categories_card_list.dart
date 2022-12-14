import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/config/route_path.dart';
import 'package:di_cho_nhanh/models/agruments/product_type.dart';
import 'package:flutter/material.dart';

import 'home_widgets.dart';

class CategoriesCardList extends StatefulWidget {
  const CategoriesCardList({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoriesCardList> createState() => _CategoriesCardListState();
}

class _CategoriesCardListState extends State<CategoriesCardList> {
  CollectionReference<Map<String, dynamic>> categories =
      FirebaseFirestore.instance.collection('Categories');
  ProductType type = ProductType.undefine;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: categories.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return snapshot.hasData
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot<Map<String, dynamic>> data = snapshot.data!.docs[index];
                      return CategoriesCartItem(
                        name: data.get('name'),
                        imageURL: data.get('image'),
                        onTap: () {
                          type = toProductType(data.get('type'));
                          Navigator.pushNamed(context, RoutePath.listProduct,
                              arguments: type);
                        },
                      );
                    })
                : const Center(child: Text('No data'));
          }
        });
  }
}
