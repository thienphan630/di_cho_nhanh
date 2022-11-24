import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constraints/styles.dart';
import '../../widgets/app_widget.dart';
import 'widgets/cart_widgets.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference<Map<String, dynamic>> cart = FirebaseFirestore.instance
        .collection('users')
        .doc('9AxMMbQDQetVKbp9kuWA')
        .collection('cart');

    return Scaffold(
      backgroundColor: const Color(0xFFF0EFEF),
      appBar: titleAppBar('Giỏ hàng'),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: cart.snapshots(),
          builder: (context, snapshot) {
            num total = 0;
            for (var element in snapshot.data!.docs) {
              total += (element.get('price') * element.get('quantity'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return snapshot.hasData
                  ? Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot<Map<String, dynamic>> data =
                                snapshot.data!.docs[index];
                            return ItemInCart(
                              name: data.get('name'),
                              price: data.get('price'),
                              quantity: data.get('quantity'),
                              imageURL: data.get('image'),
                              onMinusTap: () {
                                cart.doc(data.id).update(
                                    {'quantity': data.get('quantity') - 0.5});
                              },
                              onPlusTap: () {
                                cart.doc(data.id).update(
                                    {'quantity': data.get('quantity') + 0.5});
                              },
                              onDeleteTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      elevation: 24,
                                      content: const Text(
                                          'Bạn có chắc chắn muốn xóa món hàng này không?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              cart.doc(data.id).delete().then(
                                                    (value) =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                  );
                                            },
                                            child: const Text('Có')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Không'))
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                        )),
                        Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: TotalPayment(total: total),
                        ),
                        const PaymentButton()
                      ],
                    )
                  : const Center(child: Text('Không có hàng trong giỏ'));
            }
          }),
    );
  }
}
