import 'package:flutter/widgets.dart';

class FavoriteProvider with ChangeNotifier {
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;
  void changeFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}
