import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../config/route_path.dart';
import '../../../constraints/constraints.dart';
import '../../../models/agruments/auth_agrument.dart';
import 'widgets/widgets_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key, required this.authType}) : super(key: key);
  final AuthType authType;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kGrayBackgroundColor,
        appBar: AppBar(
          toolbarHeight: size.height / 5,
          automaticallyImplyLeading: false,
          backgroundColor: kGrayBackgroundColor,
          elevation: 0,
          title: Text(
            authType == AuthType.login ? 'Đăng Nhập' : 'Đăng ký',
            style: const TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: kBlackColor),
          ),
        ),
        body: Column(
          children: [
            CustomButton(
              text: 'Người mua',
              onTap: () {
                Navigator.pushNamed(context, RoutePath.loginWithPhone,
                    arguments: AuthAgrument(Role.buyer, authType));
              },
            ),
            const SizedBox(height: kDefaultPadding),
            CustomButton(
              text: 'Người bán',
              onTap: () {
                Navigator.pushNamed(context, RoutePath.loginWithPhone,
                    arguments: AuthAgrument(Role.seller, authType));
              },
            ),
          ],
        ));
  }
}

Future<void> addUserToFireStore(String uid) async {
  CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection('users');
  users.doc(uid).set({});
  users.doc(uid).collection('cart');
}
