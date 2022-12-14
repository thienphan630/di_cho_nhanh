import 'package:di_cho_nhanh/models/agruments/auth_agrument.dart';
import 'package:flutter/material.dart';

import '../../constraints/constraints.dart';
import 'widgets/auth_form.dart';

class LoginWithPhoneScreen extends StatelessWidget {
  const LoginWithPhoneScreen({Key? key, required this.auth}) : super(key: key);
  final AuthAgrument auth;
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
          auth.authType == AuthType.login
              ? auth.role == Role.buyer
                  ? 'Đăng Nhập Người Mua'
                  : 'Đăng Nhập Người Bán'
              : auth.role == Role.buyer
                  ? 'Đăng ký người mua'
                  : 'Đăng ký người bán',
          style: const TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: kBlackColor),
        ),
      ),
      body: FormAuth(authentication: auth),
    );
  }
}
