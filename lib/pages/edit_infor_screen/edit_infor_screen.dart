import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/agruments/auth_agrument.dart';
import '../../providers/auth_provider.dart';
import '../../utilities/get_user_id.dart';
import '../../widgets/app_widget.dart';

class EditInforScreen extends StatelessWidget {
  const EditInforScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Role role = Provider.of<AuthProvider>(context, listen: false).getRole;
    DocumentReference<Map<String, dynamic>> user = getUserInfor(role);

    TextEditingController firstName = TextEditingController();
    TextEditingController lastName = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController storeName = TextEditingController();

    List<Widget> userInf(String firstNameHintText, String lastNameHintText,
        String emailHintText, String addressHintText) {
      return [
        RowInfor(
          rowName: 'Tên',
          controller: firstName,
          hintText: firstNameHintText,
        ),
        RowInfor(
          rowName: 'Họ',
          controller: lastName,
          hintText: lastNameHintText,
        ),
        RowInfor(
          rowName: 'Email',
          controller: email,
          hintText: emailHintText,
        ),
        RowInfor(
          rowName: 'Địa chỉ',
          controller: address,
          hintText: addressHintText,
        ),
      ];
    }

    List<Widget> sellerInf(
        String firstNameHintText,
        String lastNameHintText,
        String emailHintText,
        String addressHintText,
        String storeNameHintText) {
      return [
        RowInfor(
          rowName: 'Tên',
          controller: firstName,
          hintText: firstNameHintText,
        ),
        RowInfor(
          rowName: 'Họ',
          controller: lastName,
          hintText: lastNameHintText,
        ),
        RowInfor(
          rowName: 'Email',
          controller: email,
          hintText: emailHintText,
        ),
        RowInfor(
          rowName: 'Địa chỉ',
          controller: address,
          hintText: addressHintText,
        ),
        RowInfor(
          rowName: 'Tên cửa hàng',
          controller: storeName,
          hintText: storeNameHintText,
        ),
      ];
    }

    return Scaffold(
      appBar:
          titleAppBar(context: context, title: 'Chỉnh sửa thông tin'),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: user.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              DocumentSnapshot<Map<String, dynamic>> data = snapshot.data!;
              return Column(
                children: [
                  Center(
                    child: Column(
                      children: role == Role.seller
                          ? sellerInf(
                              data.get('firstName'),
                              data.get('lastName'),
                              data.get('email'),
                              data.get('address'),
                              data.get('storeName'))
                          : userInf(
                              data.get('firstName'),
                              data.get('lastName'),
                              data.get('email'),
                              data.get('address'),
                            ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        firstName.text = firstName.text.isEmpty
                            ? data.get('firstName')
                            : firstName.text;
                        lastName.text = lastName.text.isEmpty
                            ? data.get('lastName')
                            : lastName.text;
                        email.text =
                            email.text.isEmpty ? data.get('email') : email.text;
                        address.text = address.text.isEmpty
                            ? data.get('address')
                            : address.text;
                        if (role == Role.seller) {
                          storeName.text = storeName.text.isEmpty
                              ? data.get('storeName')
                              : storeName.text;
                        }
                        role == Role.seller
                            ? FirebaseFirestore.instance
                                .collection('sellers')
                                .doc(getUserId())
                                .update({
                                'firstName': firstName.text,
                                'lastName': lastName.text,
                                'email': email.text,
                                'address': address.text,
                                'storeName': storeName.text,
                              }).then((value) => {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text('Cập nhật thành công')))
                                    })
                            : FirebaseFirestore.instance
                                .collection('users')
                                .doc(getUserId())
                                .update({
                                'firstName': firstName.text,
                                'lastName': lastName.text,
                                'email': email.text,
                                'address': address.text,
                              }).then((value) => {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text('Cập nhật thành công')))
                                    });
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: const Text('Cập nhật'))
                ],
              );
            } else {
              return const Center(child: Text('No data'));
            }
          },
        ),
      ),
    );
  }
}

class RowInfor extends StatelessWidget {
  const RowInfor({
    Key? key,
    required this.rowName,
    required this.controller,
    required this.hintText,
  }) : super(key: key);
  final String rowName;
  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(12),
      title: Row(
        children: [
          Expanded(
              flex: 1,
              child: Text(
                '$rowName:',
                textAlign: TextAlign.start,
              )),
          Expanded(
              flex: 3,
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
