import 'package:di_cho_nhanh/models/agruments/auth_agrument.dart';
import 'package:di_cho_nhanh/models/user_model.dart';
import 'package:di_cho_nhanh/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Sign out firebase authentication
Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

///Save user to share preferences
void saveUserToLocal(UserLocalModal user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String role = user.role;
  String id = user.id;
  prefs.setString('role', role);
  prefs.setString('id', id);
}

///Get user from share preferences
Future<UserLocalModal?> getUserFromLocal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? role = prefs.getString('role');
  String? id = prefs.getString('id');
  if (role != null && id != null) {
    return UserLocalModal(role: role, id: id);
  } else {
    return null;
  }
}

///Delete user from share preferences
void deleteUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('user');
}

///login with data from share preferences
void login(BuildContext context, [bool mounted = true]) async {
  UserLocalModal? data = await getUserFromLocal();
  if (data != null) {
    Role role = stringToRoleEnum(data.role);
    if (!mounted) {
      return;
    }
    Provider.of<AuthProvider>(context, listen: false).updateRole(role);
  }
}
