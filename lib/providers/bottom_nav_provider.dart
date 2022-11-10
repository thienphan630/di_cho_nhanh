import 'package:flutter/widgets.dart';

class BottomIndex with ChangeNotifier {
  int _bottomIndex = 0;
  int get bottomIndex => _bottomIndex;
  void changeBottomIndex(index) {
    _bottomIndex = index;
    notifyListeners();
  }
}
