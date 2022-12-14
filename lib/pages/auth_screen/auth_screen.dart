import 'package:flutter/material.dart';

import '../../config/route_path.dart';
import '../../constraints/constraints.dart';
import '../../models/agruments/auth_agrument.dart';
import 'widgets/widgets_auth.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

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
          title: const Text(
            'Đăng Nhập/ Đăng ký',
            style: TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: kBlackColor),
          ),
        ),
        body: Column(
          children: [
            CustomButton(
              text: 'Đăng Nhập',
              onTap: () {
                Navigator.pushNamed(context, RoutePath.login,
                    arguments: AuthTypeAgrument(AuthType.login));
              },
            ),
            const SizedBox(height: kDefaultPadding),
            CustomButton(
              text: 'Đăng ký',
              onTap: () {
                Navigator.pushNamed(context, RoutePath.login,
                    arguments: AuthTypeAgrument(AuthType.signin));
              },
            ),
            const SizedBox(height: kDefaultPadding),
          ],
        ));
  }
}
