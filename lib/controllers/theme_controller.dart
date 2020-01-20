import 'package:flutter/foundation.dart';

class ThemeController with ChangeNotifier {

  bool nightMode = true;

  void onChangeNightMode(value) {
    nightMode = value;
    notifyListeners();
  }

}
