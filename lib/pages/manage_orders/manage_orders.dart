import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/widgets/title_appbar.dart';
import 'package:flutter/material.dart';

import '../../models/order_history_model.dart';
import '../../utilities/get_user_id.dart';

class ManageOrderScreen extends StatefulWidget {
  const ManageOrderScreen({super.key});

  @override
  State<ManageOrderScreen> createState() => _ManageOrderScreenState();
}

class _ManageOrderScreenState extends State<ManageOrderScreen> {
  @override
  Widget build(BuildContext context) {
    String userId = getUserId();
    CollectionReference<Map<String, dynamic>> orders =
        FirebaseFirestore.instance.collection('order_history');

    return Scaffold(
      appBar: titleAppBar('Danh sách đơn hàng'),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: orders.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot<Map<String, dynamic>> data =
                    snapshot.data!.docs[index];
                DocumentReference<Map<String, dynamic>> product = FirebaseFirestore.instance
                    .collection('products')
                    .doc(data.get('productId'));
                String selectedStatus = data.get('status');
                return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: product.snapshots(),
                  builder: (context, subSnapshot) {
                    if (subSnapshot.hasData) {
                      if (subSnapshot.data!.get('seller') == userId) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
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
                            trailing: DropdownButton<String>(
                              value: selectedStatus,
                              onChanged: (newValue) {
                                orders
                                    .doc(data.id)
                                    .update({'status': newValue});
                                setState(() {
                                  selectedStatus = newValue!;
                                });
                              },
                              items: status
                                  .map<DropdownMenuItem<String>>(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item),
                                          ))
                                  .toList(),
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('Bạn không có đơn hàng nào'),
                        );
                      }
                    } else {
                      return const Center(
                        child: Text('Bạn không có đơn hàng nào'),
                      );
                    }
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text('Bạn không có đơn hàng nào'),
            );
          }
        },
      ),
    );
  }
}
