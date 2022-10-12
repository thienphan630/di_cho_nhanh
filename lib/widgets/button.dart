import 'package:flutter/material.dart';

import '../constraints/color.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    required this.width,
    required this.color, required this.onPress,
  }) : super(key: key);
  final String text;
  final double width;
  final Color color;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kPrimaryColor),
        color: color,
      ),
      width: width,
      height: 50,
      child: TextButton(
        onPressed: onPress,
        child: Text(
          text,
          style: TextStyle(
            color: color == kPrimaryColor ? kSecondaryColor : kPrimaryColor,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
