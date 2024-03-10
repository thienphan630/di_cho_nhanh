import 'package:flutter/material.dart';

import '../../../../constraints/constraints.dart';

class BannerCustom extends StatelessWidget {
  const BannerCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2 * kDefaultPadding),
      height: size.height / 3,
      child: Stack(
        alignment: Alignment.center,
        textDirection: TextDirection.rtl,
        children: [
          Image.asset(
            'assets/images/rau.png',
            height: size.height / 3.5,
            width: double.infinity,
          ),
          Container(
            height: size.height / 5,
            margin: const EdgeInsets.symmetric(horizontal: 2 * kDefaultPadding),
            padding: const EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      color: Color.fromRGBO(0, 0, 0, 0.12))
                ]),
            child: const Column(
              children: [
                Text(
                  'Sứ mệnh của thực phẩm sạch',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.kBlackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10),
                Text(
                  'Vì sức khỏe cộng đồng, phát triển kinh tế xã hội. “ Sản xuất, kinh doanh, tiêu dùng rau, thịt an toàn “.',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                      color: AppColor.kBlackColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
