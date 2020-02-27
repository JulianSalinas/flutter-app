import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc with ChangeNotifier {

  bool _nightMode = true;
  bool get nightMode => _nightMode;

  List<Color> _colors;
  List<Color> get colors => _colors;

  ThemeBloc() {
    SharedPreferences.getInstance().then(loadTheme);
  }

  loadTheme(SharedPreferences prefs) {
    if(prefs.getBool('nightMode') != null) {
      _nightMode = prefs.getBool('nightMode');
    }
    prefs.setBool('nightMode', _nightMode);
    notifyListeners();
  }

  set nightMode(nightMode) {
    _nightMode = nightMode;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('nightMode', _nightMode);
      notifyListeners();
    });
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
