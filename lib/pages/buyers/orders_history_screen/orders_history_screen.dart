import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/functions/snackbar_message.dart';
import 'package:di_cho_nhanh/models/order_history_model.dart';
import 'package:di_cho_nhanh/utilities/get_user_id.dart';
import 'package:di_cho_nhanh/widgets/app_widget.dart';
import 'package:flutter/material.dart';

class OrdersHistoryScreen extends StatelessWidget {
  const OrdersHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String id = getUserId();
    Query<Map<String, dynamic>> orders = FirebaseFirestore.instance
        .collection('order_history')
        .where('buyerId', isEqualTo: id);
    return Scaffold(
      appBar: titleAppBar(
          context: context, title: 'Lịch sử đặt hàng', automaticallyImplyLeading: true),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: orders.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot<Map<String, dynamic>> data =
                    snapshot.data!.docs[index];
                DocumentReference<Map<String, dynamic>> products =
                    FirebaseFirestore.instance
                        .collection('products')
                        .doc(data.get('productId'));
                return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: products.snapshots(),
                  builder: (context, subSnapshot) {
                    if (subSnapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: CustomListTile(
                          data: data,
                          subSnapshot: subSnapshot,
                        ),
                      );
                    } else {
                      return const Text('No data');
                    }
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.data,
    required this.subSnapshot,
  });

  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  final AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> subSnapshot;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: Image.memory(
          base64Decode(subSnapshot.data!.get('image')),
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${subSnapshot.data!.get('name')}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Số lương đặt hàng: ${data.get('quantity')}',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
      trailing: GestureDetector(
          onTap: () {
            if (data.get('status') != status[3]) {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomAlertDialog(data: data);
                },
              );
            }
          },
          child: Text('${data.get('status')}')),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.data,
  });

  final QueryDocumentSnapshot<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Bạn muốn hủy đơn hàng không?'),
      actions: [
        ElevatedButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('order_history')
                .doc(data.id)
                .update({'status': status[3]}).then((_) {
              Navigator.pop(context);
              snackbarMessage(
                  context: context, message: 'Huỷ đơn hàng thành công');
            });
          },
          child: const Text('Có'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Không'),
        ),
      ],
    );
  }
}
