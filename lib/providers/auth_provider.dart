import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/agruments/auth_agrument.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  Role _role = Role.undefine;

  Role get getRole => _role;

  void updateRole(Role role) {
    _role = role;
    notifyListeners();
  }

  AuthProvider() {
    updateRole(Role.undefine);
  }
}

void saveUserToLocal(UserLocalModal user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String role = user.role;
  String id = user.id;
  prefs.setString('role', role);
  prefs.setString('id', id);
}

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

void deleteUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('user');
}

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
