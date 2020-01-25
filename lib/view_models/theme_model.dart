import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ThemeModel with ChangeNotifier {

  Brightness _brightness = Brightness.dark;
  Brightness get brightness => _brightness;

  bool _nightMode = true;
  bool get nightMode => _nightMode;

  set nightMode(nightMode) {
    _nightMode = nightMode;
    _brightness = _nightMode ? Brightness.dark : Brightness.light;
    notifyListeners();
  }

}
