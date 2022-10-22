import 'package:di_cho_nhanh/constraints/styles.dart';
import 'package:di_cho_nhanh/widgets/app_widget.dart';
import 'package:flutter/material.dart';

import 'widgets/cart_widgets.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFEF),
      appBar: titleAppBar('Giỏ hàng'),
      body: Column(
        children: [
          const Expanded(child: ListItemInCart()),
          const Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: TotalPayment(),
          ),
          Container(
            margin: const EdgeInsets.only(
                left: 2 * kDefaultPadding,
                right: 2 * kDefaultPadding,
                bottom: kDefaultPadding),
            width: double.infinity,
            height: 42,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: Color(0xFFF6CC48),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: const Text(
              'Thủ tục thanh toán',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
