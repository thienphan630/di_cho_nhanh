import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/product_agrument.dart';
import 'categories_widgets.dart';

Widget listProducts(String id) {
  CollectionReference<Map<String, dynamic>> products =
      FirebaseFirestore.instance.collection('products');
  return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: products.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return snapshot.hasData
              ? SizedBox(
                  height: 160,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        return Item(
                          name: data['name'],
                          price: data['price'],
                          imageURL: data['image'],
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
      });
}
