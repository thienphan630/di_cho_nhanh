import 'package:flutter/material.dart';

PreferredSizeWidget titleAppBar(
    {required BuildContext context,
    required String title,
    bool? isHavebackButton}) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: true,
    backgroundColor: Colors.white,
    leading: (isHavebackButton != null && isHavebackButton)
        ? BackButton(
            color: Colors.black,
            onPressed: (() => Navigator.pop(context)),
          )
        : null,
    title: Text(
      title,
      style: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
    ),
  );
}
