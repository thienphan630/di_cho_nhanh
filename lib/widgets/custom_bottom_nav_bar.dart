import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../constraints/constraints.dart';
import '../models/agruments/auth_agrument.dart';
import '../pages/add_product_screen/add_product_screen.dart';
import '../pages/auth_screen/auth_screen.dart';
import '../pages/categories_screen/categories_screen.dart';
import '../pages/favorite/favorite_items.dart';
import '../pages/homepage/homepage.dart';
import '../pages/cart_screen/cart_screen.dart';
import '../pages/manage_orders/manage_orders.dart';
import '../pages/manage_products/manage_products_screen.dart';
import '../pages/personal_screen/personal_screen.dart';
import '../providers/auth_provider.dart';
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
    Role role = context.watch<AuthProvider>().getRole;
    return BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        fixedColor: kPrimaryColor,
        unselectedItemColor: kGrayColor,
        currentIndex: context.watch<BottomIndex>().bottomIndex,
        onTap: _onTap,
        items: role == Role.seller ? seller : buyer);
  }
}

List<BottomNavigationBarItem> buyer = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home_filled),
    label: '',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.shopping_cart_outlined),
    label: '',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.favorite_border),
    label: '',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.inventory),
    label: '',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.person_outline),
    label: '',
  ),
];

List<BottomNavigationBarItem> seller = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home_filled),
    label: '',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.inventory),
    label: '',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.add_circle_outline_rounded),
    label: '',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.receipt),
    label: '',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.person_outline),
    label: '',
  ),
];

Widget nav(int index, Role role) {
  if (role == Role.seller) {
    switch (index) {
      case 0:
        return const Homepage();
      case 1:
        return const ManageProductsScreen();
      case 2:
        return const AddProductScreen();
      case 3:
        return const ManageOrderScreen();
      case 4:
        {
          if (FirebaseAuth.instance.currentUser != null) {
            return const Personal();
          } else {
            return const AuthScreen();
          }
        }
      default:
        return const Center(child: Text('Default'));
    }
  } else {
    switch (index) {
      case 0:
        return const Homepage();
      case 1:
        return const CategoriesScreen();
      case 2:
        return const FavoriteItems();
      case 3:
        return const ShoppingCart();
      case 4:
        {
          if (FirebaseAuth.instance.currentUser != null) {
            return const Personal();
          } else {
            return const AuthScreen();
          }
        }
      default:
        return const Center(child: Text('Default'));
    }
  }
}
