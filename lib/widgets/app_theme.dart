import 'package:flutter/material.dart';

import '../constraints/constraints.dart';

ThemeData theme() => ThemeData(
      fontFamily: 'Inter',
      primaryColor: AppColor.kPrimaryColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.kAppBarBackgroundColor,
      ),
    );
