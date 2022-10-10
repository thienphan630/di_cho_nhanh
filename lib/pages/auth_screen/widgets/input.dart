import 'package:flutter/material.dart';

import '../../../constraints/color.dart';

class Input extends StatelessWidget {
  const Input({
    Key? key,
    required this.title,
    required this.hint,
    required this.obscureText,
  }) : super(key: key);
  final String title;
  final String hint;
  final bool obscureText;
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
      TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 15, 20),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      )
    ]);
  }
}
