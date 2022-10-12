import 'package:flutter/material.dart';

import '../../constraints/constraints.dart';
import 'widgets/auth_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kGrayBackgroundColor,
        appBar: AppBar(
          toolbarHeight: size.height / 5,
          automaticallyImplyLeading: false,
          backgroundColor: kGrayBackgroundColor,
          elevation: 0,
          title: const Text(
            'Log In',
            style: TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: kBlackColor),
          ),
        ),
        body: const FormAuth(isSignUp: false));
  }
}
