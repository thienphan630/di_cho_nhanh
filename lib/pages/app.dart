import 'package:di_cho_nhanh/pages/auth_screen/auth_screen.dart';
import 'package:di_cho_nhanh/pages/auth_screen/login_screen.dart';
import 'package:di_cho_nhanh/pages/homepage/homepage.dart';
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
  @override
  void initState() {
    super.initState();
    login(context);
  }

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    Widget? defaultPage;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        defaultPage = const Homepage();
      } else {
        defaultPage = const AuthScreen();
      }
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      onGenerateRoute: generateRoute,
      home: defaultPage,
    );
  }
}
