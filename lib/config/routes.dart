import 'package:di_cho_nhanh/pages/orders_history_screen/orders_history_screen.dart';
import 'package:di_cho_nhanh/pages/personal_screen/personal_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/agruments/auth_agrument.dart';
import '../models/agruments/product_type.dart';
import '../models/agruments/product_agrument.dart';
import '../pages/add_product_screen/add_product_screen.dart';
import '../pages/auth_screen/add_infor_seller.dart';
import '../pages/auth_screen/add_infor_users.dart';
import '../pages/auth_screen/auth_screen.dart';
import '../pages/auth_screen/login_with_phone_screen.dart';
import '../pages/edit_infor_screen/edit_infor_screen.dart';
import '../pages/homepage/widget/search_screen.dart';
import '../pages/list_products/list_products_screen.dart';
import '../pages/auth_screen/login_screen.dart';
import '../pages/main_layout.dart';
import '../pages/not_found_page.dart';
import '../pages/product_detail/product_detail.dart';
import '../pages/splash_screen/splash.dart';
import 'route_path.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  bool isLogin = false;
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      isLogin = true;
    } else {
      isLogin = false;
    }
  });
  switch (settings.name) {
    //login
    case RoutePath.login:
      {
        final agrs = settings.arguments as AuthTypeAgrument;
        return MaterialPageRoute(
            builder: (context) => LoginScreen(authType: agrs.authType));
      }
    case RoutePath.loginWithPhone:
      {
        final agrs = settings.arguments as AuthAgrument;
        return MaterialPageRoute(
            builder: (context) => LoginWithPhoneScreen(
                  auth: agrs,
                ));
      }
    //shared
    case RoutePath.editInf:
      return MaterialPageRoute(builder: (context) => const EditInforScreen());
    case RoutePath.personal:
      return MaterialPageRoute(builder: (context) => const Personal());

    // users
    case RoutePath.home:
      return MaterialPageRoute(
          builder: (context) =>
              isLogin ? const MainLayout() : const AuthScreen());
    case RoutePath.auth:
      return MaterialPageRoute(builder: (context) => const AuthScreen());
    case RoutePath.addUserInfor:
      {
        final agrs = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => AddUsersInformation(phoneNumber: agrs));
      }
    case RoutePath.splashScreen:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case RoutePath.listProduct:
      {
        final agrs = settings.arguments as ProductType;
        return MaterialPageRoute(
            builder: (context) => ListProducts(type: agrs));
      }
    case RoutePath.product:
      {
        final agrs = settings.arguments as ProductAgrument;
        return MaterialPageRoute(
            builder: (context) => ProductDetail(
                  id: agrs.id,
                ));
      }
    case RoutePath.searchScreen:
      return MaterialPageRoute(builder: (context) => const SearchScreen());
    case RoutePath.ordersHistory:
      return MaterialPageRoute(
          builder: (context) => const OrdersHistoryScreen());
    //seller
    case RoutePath.addProduct:
      return MaterialPageRoute(builder: (context) => const AddProductScreen());
    case RoutePath.addSellerInfor:
      {
        final agrs = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => AddSellerInformation(phoneNumber: agrs));
      }
    //default
    default:
      return MaterialPageRoute(builder: (context) => const NotFoundPage());
  }
}
