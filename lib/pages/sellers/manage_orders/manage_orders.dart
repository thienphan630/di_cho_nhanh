import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/widgets/title_appbar.dart';
import 'package:flutter/material.dart';

import '../../../models/order_history_model.dart';
import '../../../utilities/get_user_id.dart';

class ManageOrderScreen extends StatefulWidget {
  const ManageOrderScreen({super.key});

  @override
  State<ManageOrderScreen> createState() => _ManageOrderScreenState();
}

class _ManageOrderScreenState extends State<ManageOrderScreen> {
  @override
  Widget build(BuildContext context) {
    String userId = getUserId();
    // CollectionReference<Map<String, dynamic>>
    var orderUpdate = FirebaseFirestore.instance.collection('order_history');
    var orders = FirebaseFirestore.instance
        .collection('order_history')
        .orderBy('time', descending: true);

    return Scaffold(
      appBar: titleAppBar(context: context, title: 'Danh sách đơn hàng'),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: orders.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot<Map<String, dynamic>> data =
                    snapshot.data!.docs[index];
                String buyerId = data.get('buyerId');
                DocumentReference<Map<String, dynamic>> product =
                    FirebaseFirestore.instance
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
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    var buyer = FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(buyerId);
                                    return AlertDialog(
                                      content: StreamBuilder<
                                              DocumentSnapshot<
                                                  Map<String, dynamic>>>(
                                          stream: buyer.snapshots(),
                                          builder: (context, asnapshot) {
                                            if (asnapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else if (asnapshot.hasData) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                      'Thông tin người mua:'),
                                                  Text(
                                                      'Tên: ${asnapshot.data!.get('lastName')} ${asnapshot.data!.get('firstName')}'),
                                                  Text(
                                                      'Địa chỉ: ${asnapshot.data!.get('address')}'),
                                                  Text(
                                                      'Email: ${asnapshot.data!.get('email')}'),
                                                  Text(
                                                      'Số điện thoại: ${asnapshot.data!.get('phoneNumber')}'),
                                                ],
                                              );
                                            } else {
                                              return const Text('No data');
                                            }
                                          }),
                                    );
                                  });
                            },
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
                                    'Số lượng: ${data.get('quantity')}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    '${data.get('time')}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              trailing: DropdownButton<String>(
                                value: selectedStatus,
                                onChanged: (newValue) {
                                  orderUpdate
                                      .doc(data.id)
                                      .update({'status': newValue});
                                  setState(() {
                                    selectedStatus = newValue!;
                                  });
                                },
                                items: status
                                    .map<DropdownMenuItem<String>>(
                                        (String item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(item),
                                            ))
                                    .toList(),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    } else {
                      return const SizedBox();
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
