import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../config/route_path.dart';
import '../../providers/auth_provider.dart';

class Personal extends StatelessWidget {
  const Personal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            _signOut();
            deleteUser();
            Navigator.pushNamed(context, RoutePath.auth);
          },
          child: const Text("Đăng xuất")),
    );
  }
}

///Future<void> Sign out firebase authentication
Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
}
