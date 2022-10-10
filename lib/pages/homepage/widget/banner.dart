import 'package:flutter/material.dart';

import '../../../constraints/index.dart';

class BannerCustom extends StatelessWidget {
  const BannerCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2 * kDefaultPadding),
      height: size.height / 3,
      child: Stack(
        alignment: Alignment.topCenter,
        textDirection: TextDirection.rtl,
        children: [
          Image.asset(
            'assets/images/rau.png',
            height: size.height / 3.5,
            width: double.infinity,
          ),
          Column(
            children: [
              const Spacer(),
              Container(
                height: size.height / 6,
                margin:
                    const EdgeInsets.symmetric(horizontal: 2 * kDefaultPadding),
                padding: const EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color: Color.fromRGBO(0, 0, 0, 0.12))
                    ]),
                child: Column(
                  children: const [
                    Text(
                      'Sứ mệnh của thực phẩm sạch',
                      style: TextStyle(
                          color: kBlackColor,
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Vì sức khỏe cộng đồng, phát triển kinh tế xã hội. “ Sản xuất, kinh doanh, tiêu dùng rau, thịt an toàn “',
                      style: TextStyle(
                          color: kBlackColor,
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
