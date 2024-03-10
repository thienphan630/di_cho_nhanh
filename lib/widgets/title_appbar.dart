import 'package:di_cho_nhanh/constraints/color.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget titleAppBar(
    {required BuildContext context,
    required String title,
    bool? automaticallyImplyLeading}) {
  return AppBar(
    automaticallyImplyLeading: automaticallyImplyLeading ?? false,
    centerTitle: true,
    backgroundColor: AppColor.kAppBarBackgroundColor,
    title: Text(
      title,
      style: const TextStyle(
        color: AppColor.kBlackColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
