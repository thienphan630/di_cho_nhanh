import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/functions/snackbar_message.dart';
import 'package:flutter/material.dart';

import '../models/add_to_cart_model.dart';
import '../utilities/get_user_id.dart';

void addToCartTap(
    BuildContext context, String id, bool isInCart, dynamic data) {
  CollectionReference cart = FirebaseFirestore.instance
      .collection('users')
      .doc(getUserId())
      .collection('cart');
  cart.get().then((value) {
    for (QueryDocumentSnapshot<Object?> element in value.docs) {
      if (id == element.get('id')) {
        isInCart = true;
        snackbarMessage(context: context, message: 'Món hàng đã có trong giỏ');
        break;
      }
    }
    if (!isInCart) {
      cart
          .add(
        AddToCart(
          id: id,
          name: data.get('name'),
          image: data.get('image'),
          price: data.get('price'),
          quantity: 1.0,
        ).toMap(),
      )
          .whenComplete(() {
        snackbarMessage(context: context, message: 'Đã thêm vào giỏ hàng');
      }).catchError(
        (e) {
          snackbarMessage(
              context: context, message: 'Không thể thêm hàng vào giỏ');
          return e;
        },
      );
    }
  });
}
