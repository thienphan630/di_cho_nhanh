import 'package:flutter/material.dart';

PreferredSizeWidget titleAppBar(String title) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.white,
    title:  Text(
      title,
      style: const  TextStyle(
          color: Color(0xFFC68F02), fontSize: 20, fontWeight: FontWeight.w700),
    ),
  );
}
