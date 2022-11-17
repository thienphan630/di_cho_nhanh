import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/models/categories.dart';
import 'package:flutter/material.dart';

import '../../../models/product_agrument.dart';
import 'item.dart';

class ListItems extends StatelessWidget {
  const ListItems({
    Key? key,
    required this.type,
  }) : super(key: key);
  final ProductType type;
  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;
    var products =
        db.collection('products').where('type', isEqualTo: categories(type));

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: products.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return snapshot.hasData
                ? GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 20,
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3),
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return Item(
                        name: data.get('name'),
                        imageURL: data.get('image'),
                        price: data.get('price'),
                        onTap: () {
                          Navigator.pushNamed(context, '/product',
                              arguments: ProductAgrument(
                                  snapshot.data!.docs[index].id));
                        },
                        onBuyTap: () {
                          log('Add to card');
                        },
                      );
                    },
                  )
                : const Center(child: Text('No data'));
          }
        });
  }
}
