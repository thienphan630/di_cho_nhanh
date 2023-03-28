import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/models/add_to_cart_model.dart';
import 'package:di_cho_nhanh/utilities/get_user_id.dart';
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
      appBar: titleAppBar(context: context, title: 'Chi tiết sản phẩm', isHavebackButton: true),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: products.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              var data = snapshot.data!;
              return ProductDetailContent(
                name: data.get('name'),
                price: data.get('price'),
                sold: data.get('sold'),
                imageURL: data.get('image'),
                stars: data.get('stars'),
                addToCartTap: () {
                  CollectionReference cart = FirebaseFirestore.instance
                      .collection('users')
                      .doc(getUserId())
                      .collection('cart');
                  cart.get().then((value) {
                    for (QueryDocumentSnapshot<Object?> element in value.docs) {
                      if (id == element.get('id')) {
                        isInCart = true;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
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
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Không thể thêm hàng vào giỏ')));
                      });
                    }
                  });
                },
                buyNowTap: () {},
                document: data.get('seller'),
              );
            }
          },
        ),
      ),
    );
  }
}
