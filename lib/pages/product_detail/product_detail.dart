import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/functions/favorite_func.dart';
import 'package:di_cho_nhanh/models/favorite_model.dart';
import 'package:flutter/material.dart';

import '../../functions/trading_func.dart';
import '../../widgets/title_appbar.dart';
import 'widgets/widgets_product_detail.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    DocumentReference<Map<String, dynamic>> products =
        FirebaseFirestore.instance.collection('products').doc(id);
    bool isInCart = false;

    return Scaffold(
      appBar: titleAppBar(
          context: context, title: 'Chi tiết sản phẩm', isHavebackButton: true),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: products.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              var data = snapshot.data!;
              return ProductDetailContent(
                  id: id,
                  name: data.get('name'),
                  price: data.get('price'),
                  sold: data.get('sold'),
                  imageURL: data.get('image'),
                  stars: data.get('stars'),
                  addToCartTap: () {
                    addToCartTap(context, id, isInCart, data);
                  },
                  buyNowTap: () {},
                  document: data.get('seller'),
                  onFavoriteTap: () {
                    onFavoriteTap(
                      FavoriteModel(
                        id: data.id,
                        name: data.get('name'),
                        image: data.get('image'),
                        price: data.get('price'),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
