import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../config/route_path.dart';
import '../../../models/user_model.dart';
import '../../../utilities/get_user_id.dart';
import '../../../widgets/app_widget.dart';
import 'widgets/widgets_auth.dart';

class AddUsersInformation extends StatefulWidget {
  const AddUsersInformation({super.key, required this.phoneNumber});
  final String phoneNumber;
  @override
  State<AddUsersInformation> createState() => _AddUsersInformationState();
}

class _AddUsersInformationState extends State<AddUsersInformation> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();

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
            FirebaseFirestore.instance.collection('users').doc(id);
        user.set(
          UserModel(
            firstName: firstName.text,
            lastName: lastName.text,
            email: email.text,
            address: address.text,
            phoneNumber: '+84${widget.phoneNumber}',
          ).toMap(),
        );
        Navigator.pushReplacementNamed(context, RoutePath.home);
      }
    } else {
      log('no user');
    }
  }
}
