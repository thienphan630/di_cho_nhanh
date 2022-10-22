import 'package:flutter/material.dart';

class TotalPayment extends StatelessWidget {
  const TotalPayment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'Tổng tiền',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Text(
          '254.000 đ',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFFCBB700)),
        )
      ],
    );
  }
}
