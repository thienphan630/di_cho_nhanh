import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/models/add_to_cart_model.dart';
import 'package:flutter/material.dart';

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
      appBar: titleAppBar('Chi tiết sản phẩm'),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: products.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            Map<String, dynamic>? data = snapshot.data!.data();
            return ProductDetailContent(
              name: data!['name'],
              price: data['price'],
              sold: data['sold'],
              imageURL: data['image'],
              stars: data['stars'],
              addToCartTap: () {
                CollectionReference cart = FirebaseFirestore.instance
                    .collection('users')
                    .doc('9AxMMbQDQetVKbp9kuWA')
                    .collection('cart');
                cart.get().then((value) {
                  for (var element in value.docs) {
                    if (id == element.get('id')) {
                      isInCart = true;
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Món hàng đã có trong giỏ')));
                      break;
                    }
                  }
                  if (!isInCart) {
                    cart
                        .add(
                          AddToCart(
                            id: id,
                            name: data['name'],
                            image: data['image'],
                            price: data['price'],
                            quantity: 1.0,
                          ).toMap(),
                        )
                        .whenComplete(() => ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text('Đã thêm vào giỏ hàng'))))
                        .catchError((e) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Không thể thêm hàng vào giỏ')));
                    });
                  }
                });
              },
              buyNowTap: () {},
            );
          }
        },
      ),
    );
  }
}
