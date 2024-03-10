import 'package:flutter/material.dart';

import '../../../../widgets/button.dart';
import '../../../../constraints/color.dart';
import '../splash_data.dart';
import 'splash_item.dart';

class SplashSlider extends StatefulWidget {
  const SplashSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashSlider> createState() => _SplashSliderState();
}

class _SplashSliderState extends State<SplashSlider> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Flexible(
          flex: 4,
          child: PageView.builder(
            onPageChanged: (index) {
              setState(() {
                _pageIndex = index;
              });
            },
            itemCount: data.length,
            itemBuilder: (context, index) => Item(
              image: data[index]['image'].toString(),
              title: data[index]['title'].toString(),
              subTitle: data[index]['subtitle'].toString(),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (_, index) => Center(
              child: Container(
                margin: const EdgeInsets.all(10),
                width: _pageIndex == index ? 28 : 9,
                height: 5,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  color: Color(0xFF3D5CFF),
                ),
              ),
            ),
          ),
        ),
        _pageIndex == 2
            ? Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Button(
                      text: 'Sign up',
                      width: size.width * 2 / 5,
                      color: AppColor.kPrimaryColor,
                      onPress: () {
                        Navigator.pushReplacementNamed(context, '/signup');
                      },
                    ),
                    Button(
                      text: 'Log in',
                      width: size.width * 2 / 5,
                      color: AppColor.kSecondaryColor,
                      onPress: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                    ),
                  ],
                ),
              )
            : const Spacer(),
      ],
    );
  }
}
