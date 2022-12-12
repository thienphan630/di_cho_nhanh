import 'package:di_cho_nhanh/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/agruments/auth_agrument.dart';
import '../providers/bottom_nav_provider.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = context.watch<BottomIndex>().bottomIndex;
    Role role = context.watch<AuthProvider>().getRole;
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(),
      body: nav(index, role),
    );
  }
}
