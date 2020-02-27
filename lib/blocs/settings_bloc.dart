import 'package:letsattend/auth/auth_engine.dart';
import 'package:letsattend/blocs/theme_bloc.dart';

class SettingsBloc extends ThemeBloc {

  AuthEngine _authEngine = AuthEngine.Firebase;

  AuthEngine get authEngine => _authEngine;

  set authEngine(AuthEngine value) {
    _authEngine = value;
    notifyListeners();
  }

}