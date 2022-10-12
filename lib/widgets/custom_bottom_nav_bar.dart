import 'package:di_cho_nhanh/pages/payment/firebase_test.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../constraints/constraints.dart';
import '../pages/homepage/homepage.dart';
import '../providers/bottom_nav_provider.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  _onTap(value) {
    context.read<BottomIndex>().changeBottomIndex(value);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: kPrimaryColor,
      fixedColor: kPrimaryColor,
      unselectedItemColor: kGrayColor,
      currentIndex: context.watch<BottomIndex>().getBottomIndex(),
      onTap: _onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: '',
        ),
      ],
    );
  }
}

Widget nav(int index) {
  switch (index) {
    case 0:
      return const Homepage();
    case 1:
      return const Firebase();
    case 2:
      return const Center(child: Text('Favorite'));
    case 3:
      return const Center(child: Text('Card'));
    case 4:
      return const Center(child: Text('Personal '));
    default:
      return const Center(child: Text('Default'));
  }
}
