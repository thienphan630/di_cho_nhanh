import 'package:flutter/material.dart';

import '../../constraints/constraints.dart';
import 'widgets/splash_slider.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
            margin: EdgeInsets.only(top: size.height / 10),
            child: const SplashSlider()),
        Container(
          margin:
              EdgeInsets.only(top: size.height / 11, right: kDefaultPadding),
          alignment: Alignment.topRight,
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            child: const Text(
              'Skip',
              style: TextStyle(color: kSecondaryTextColor, fontSize: 14),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ],
    ));
  }
}
