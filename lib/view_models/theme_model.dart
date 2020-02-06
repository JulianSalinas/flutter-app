import 'package:flutter/material.dart';

class ThemeModel with ChangeNotifier {

  bool _nightMode = true;
  bool get nightMode => _nightMode;

  List<Color> _colors;
  List<Color> get colors => _colors;

  set nightMode(nightMode) {
    _nightMode = nightMode;
    notifyListeners();
  }

  set colors(List<Color> colors) {
    _colors = colors;
    notifyListeners();
  }

  bool get isColorful {
    return _colors == null || _colors.length <= 0;
  }

  Brightness get brightness {
    return _nightMode ? Brightness.dark : Brightness.light;
  }

}
