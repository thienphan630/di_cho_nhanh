import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/agruments/product_agrument.dart';
import 'categories_widgets.dart';

Widget listProducts(String type) {
  Query<Map<String, dynamic>> products = FirebaseFirestore.instance
      .collection('products')
      .where('type', isEqualTo: type);

  return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    stream: products.snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else {
        if (snapshot.data!.docs.isEmpty) {
          return const SizedBox.shrink();
        }
        return snapshot.hasData
            ? SizedBox(
                height: 160,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot<Map<String, dynamic>> data = snapshot.data!.docs[index];
                      return Item(
                        name: data.get('name') ?? '',
                        price: data.get('price') ?? '',
                        imageURL: data.get('image') ?? '',
                        onTap: () {
                          Navigator.pushNamed(context, '/product',
                              arguments: ProductAgrument(
                                  snapshot.data!.docs[index].id));
                        },
                      );
                    }),
              )
            : const Center(child: Text('No data'));
      }
    },
  );
}
