import 'package:flutter/widgets.dart';

class BottomIndex with ChangeNotifier {
  int _bottomIndex = 0;
  int getBottomIndex() => _bottomIndex;
  void changeBottomIndex(index) {
    _bottomIndex = index;
    notifyListeners();
  }
}
