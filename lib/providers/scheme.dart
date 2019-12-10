import 'package:flutter/foundation.dart';

class Scheme with ChangeNotifier {
  bool nightMode = true;

  void onChangeNightMode(value) {
    nightMode = value;
    notifyListeners();
  }
}
