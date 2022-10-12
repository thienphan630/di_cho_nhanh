import 'package:flutter/material.dart';

import '../constraints/constraints.dart';

ThemeData theme() => ThemeData(
      fontFamily: 'Inter',
      primaryColor: kPrimaryColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: kPrimaryColor,
      ),
    );
