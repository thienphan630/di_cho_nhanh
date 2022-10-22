import 'package:flutter/material.dart';

PreferredSizeWidget titleAppBar() {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.white,
    title: const Text(
      'Hàng hóa',
      style: TextStyle(
          color: Color(0xFFC68F02), fontSize: 20, fontWeight: FontWeight.w700),
    ),
  );
}
