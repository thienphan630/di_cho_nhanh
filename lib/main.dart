import 'package:di_cho_nhanh/providers/favorite_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'pages/app.dart';
import 'providers/bottom_nav_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => BottomIndex(),
      ),
      ChangeNotifierProvider(
        create: (_) => FavoriteProvider(),
      )
    ],
    child: const MyApp(),
  ));
}
