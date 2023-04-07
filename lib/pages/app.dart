import 'dart:developer';

import 'package:di_cho_nhanh/config/route_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../config/routes.dart';
import '../providers/auth_provider.dart';
import '../widgets/app_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    login(context);
    isUserLogin();
  }

  void isUserLogin() async {
    if (FirebaseAuth.instance.currentUser != null) {
      log("User is already logged in");
      isLogin = true;
    } else {
      log("No User");
      isLogin = false;
    }
  }

  // This widget is the root of application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      initialRoute: isLogin ? RoutePath.home : RoutePath.auth,
      onGenerateRoute: generateRoute,
    );
  }
}
