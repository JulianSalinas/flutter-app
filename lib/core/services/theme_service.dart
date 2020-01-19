import 'package:flutter/foundation.dart';

class ThemeService with ChangeNotifier {
  bool nightMode = true;

  void onChangeNightMode(value) {
    nightMode = value;
    notifyListeners();
  }
}
