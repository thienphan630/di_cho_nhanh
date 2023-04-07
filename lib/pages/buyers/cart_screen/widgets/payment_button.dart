import 'package:flutter/material.dart';

import '../../../../constraints/styles.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({
    Key? key,
    required this.onPaymentTap,
  }) : super(key: key);
  final VoidCallback onPaymentTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPaymentTap,
      child: Container(
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
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
