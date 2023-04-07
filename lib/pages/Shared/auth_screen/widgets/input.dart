import 'package:di_cho_nhanh/constraints/styles.dart';
import 'package:flutter/material.dart';

import '../../../../constraints/color.dart';

class Input extends StatelessWidget {
  const Input({
    Key? key,
    required this.title,
    required this.controller,
  }) : super(key: key);
  final String title;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: const TextStyle(
            color: kSecondaryTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
      const SizedBox(height: 4),
      Container(
        padding: const EdgeInsets.all(kDefaultPadding * 2 / 3),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Row(
          children: [
            const Text('+84 |',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.phone,
                cursorHeight: 20,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16)),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
