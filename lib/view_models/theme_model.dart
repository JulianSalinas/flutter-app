import 'package:flutter/foundation.dart';

class ThemeModel with ChangeNotifier {

  bool nightMode = true;

  void onChangeNightMode(value) {
    nightMode = value;
    notifyListeners();
  }

}
