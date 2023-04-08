import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'pages/app.dart';
import 'providers/auth_provider.dart';
import 'providers/bottom_nav_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ErrorWidget.builder =
      (details) => const Center(child: CircularProgressIndicator());
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => BottomIndex(),
      ),
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}
