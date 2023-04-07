import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../config/route_path.dart';
import '../../../models/seller_model.dart';
import '../../../utilities/get_user_id.dart';
import '../../../widgets/app_widget.dart';
import 'widgets/widgets_auth.dart';

class AddSellerInformation extends StatefulWidget {
  const AddSellerInformation({super.key, required this.phoneNumber});
  final String phoneNumber;
  @override
  State<AddSellerInformation> createState() => _AddSellerInformationState();
}

class _AddSellerInformationState extends State<AddSellerInformation> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController storeName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar:
          titleAppBar(context: context, title: 'Thông tin người dùng'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: InformationInput(
                        formKey: formKey,
                        controller: firstName,
                        labelText: 'Tên',
                        validatorText: 'Vui lòng nhập tên'),
                  ),
                  Expanded(
                    child: InformationInput(
                        formKey: formKey,
                        controller: lastName,
                        labelText: 'Họ',
                        validatorText: 'Vui lòng nhập họ'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              InformationInput(
                  formKey: formKey,
                  controller: email,
                  labelText: 'Email',
                  validatorText: 'Vui lòng nhập email'),
              const SizedBox(height: 12),
              InformationInput(
                  formKey: formKey,
                  controller: address,
                  labelText: 'Địa chỉ',
                  validatorText: 'Vui lòng nhập địa chỉ'),
              const SizedBox(height: 12),
              InformationInput(
                  formKey: formKey,
                  controller: storeName,
                  labelText: 'Tên cửa hàng của bạn',
                  validatorText: 'Vui lòng nhập tên cửa hàng'),
              const SizedBox(height: 12),
              ElevatedButton(
                  onPressed: () {
                    _submitButton(formKey);
                  },
                  child: const Text('Thêm thông tin',
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      ),
    );
  }

  void _submitButton(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      if (FirebaseAuth.instance.currentUser != null) {
        String id = getUserId();
        log(id);
        DocumentReference<Map<String, dynamic>> user =
            FirebaseFirestore.instance.collection('sellers').doc(id);
        user.set(SellerModel(
          firstName: firstName.text,
          lastName: lastName.text,
          email: email.text,
          address: address.text,
          storeName: storeName.text,
          phoneNumber: '+84${widget.phoneNumber}',
        ).toMap());
        Navigator.pushReplacementNamed(context, RoutePath.home);
      }
    } else {
      log('Error');
    }
  }
}
