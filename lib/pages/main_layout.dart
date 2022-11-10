import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/bottom_nav_provider.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = context.watch<BottomIndex>().bottomIndex;
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(),
      body: nav(index),
    );
  }
}
