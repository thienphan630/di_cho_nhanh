import 'package:flutter/material.dart';

import '../models/agruments/auth_agrument.dart';

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
