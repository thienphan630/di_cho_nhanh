import 'package:di_cho_nhanh/pages/add_product_screen/add_product_screen.dart';
import 'package:flutter/material.dart';

import '../models/agruments/product_type.dart';
import '../models/agruments/product_agrument.dart';
import '../pages/list_products/list_products_screen.dart';
import '../pages/main_layout.dart';
import '../pages/auth_screen/login_screen.dart';
import '../pages/auth_screen/signup_screen.dart';
import '../pages/not_found_page.dart';
import '../pages/product_detail/product_detail.dart';
import '../pages/splash_screen/splash.dart';
import 'route_path.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // users
    case RoutePath.home:
      return MaterialPageRoute(builder: (context) => const MainLayout());
    case RoutePath.login:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case RoutePath.signup:
      return MaterialPageRoute(builder: (context) => const SignupScreen());
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

    //customer
    case RoutePath.addProduct:
      return MaterialPageRoute(builder: (context) => const AddProductScreen());
    default:
      return MaterialPageRoute(builder: (context) => const NotFoundPage());
  }
}
