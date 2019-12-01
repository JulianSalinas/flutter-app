import 'package:flutter/foundation.dart';

class Scheme with ChangeNotifier {
  bool darkMode = true;

  void onChangeDarkMode(value) {
    darkMode = value;
    notifyListeners();
  }
}
