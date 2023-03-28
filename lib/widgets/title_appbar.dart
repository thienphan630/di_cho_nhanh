import 'package:flutter/material.dart';

PreferredSizeWidget titleAppBar(
    {required BuildContext context,
    required String title,
    bool? isHavebackButton}) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: true,
    backgroundColor: Colors.white,
    leading: (isHavebackButton!=null&&isHavebackButton)? BackButton(
      color: const Color(0xFFC68F02),
      onPressed: (() => Navigator.pop(context)),
    ):null,
    title: Text(
      title,
      style: const TextStyle(
          color: Color(0xFFC68F02), fontSize: 20, fontWeight: FontWeight.w700),
    ),
  );
}
