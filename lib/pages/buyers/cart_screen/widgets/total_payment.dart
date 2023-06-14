import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TotalPayment extends StatelessWidget {
  const TotalPayment({
    Key? key,
    required this.total,
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
          "${NumberFormat('###,000').format(total)} VND",
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFFCBB700)),
        )
      ],
    );
  }
}
