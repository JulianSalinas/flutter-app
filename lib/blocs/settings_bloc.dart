import 'package:flutter/material.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/shared/engine.dart';
import 'package:letsattend/blocs/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsBloc with ChangeNotifier {

  final AuthBloc _userBloc = locator<AuthBloc>();

  /// TODO: There is just one login provider yet
  Engine _engine = Engine.Firebase;

  Engine get engine => _engine;

  set engine(Engine authEngine) {
    _engine = authEngine;
    notifyListeners();
  }

  bool _nightMode = false;

  bool get nightMode => _nightMode;

  set nightMode(nightMode) {
    _nightMode = nightMode;
    SharedPreferences.getInstance().then(saveTheme);
  }

  List<Color>? _colors;

  List<Color>? get colors => _colors;

  set colors(List<Color>? colors) {
    _colors = colors;
    notifyListeners();
  }

  SettingsBloc() {
    SharedPreferences.getInstance().then(loadTheme);
  }

  loadTheme(SharedPreferences prefs) {
    _nightMode = prefs.getBool('nightMode') ?? true;
    saveTheme(prefs);
  }

  saveTheme(SharedPreferences prefs) {
    prefs.setBool('nightMode', _nightMode);
    notifyListeners();
  }

  bool _allowPhoto = true;
  bool get allowPhoto => _allowPhoto;

  set allowPhoto(bool allowPhoto){
    _allowPhoto = allowPhoto;
    notifyListeners();
    _userBloc.allowPhoto = _allowPhoto;
  }

  bool get isColorful {
    return _colors != null && _colors!.length <= 0;
  }

  Brightness get brightness {
    return _nightMode ? Brightness.dark : Brightness.light;
  }
}
