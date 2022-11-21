import 'package:flutter/material.dart';

class TotalPayment extends StatelessWidget {
  const TotalPayment({
    Key? key, required this.total,
  }) : super(key: key);
  final num total;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Tổng tiền',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Text(
          '$total đ',
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFFCBB700)),
        )
      ],
    );
  }
}
