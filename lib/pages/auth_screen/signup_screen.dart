import 'package:flutter/material.dart';

import '../../constraints/index.dart';
import 'widgets/auth_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: kBlackColor),
              ),
              Text(
                'Enter your details below & free sign up',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: kGrayColor),
              )
            ],
          ),
        ),
        body: const FormAuth(isSignUp: true));
  }
}
