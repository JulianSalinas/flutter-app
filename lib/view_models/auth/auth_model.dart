import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/view_models/auth/auth_status.dart';
import 'package:letsattend/services/auth/firebase_auth_service.dart';


class AuthModel with ChangeNotifier {

  final FirebaseAuthService _service = locator<FirebaseAuthService>();

  User _user;
  User get user => _user;

  AuthStatus _status = AuthStatus.Uninitialized;
  AuthStatus get status => _status;

  AuthModel() {
    _service.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User user) async {
    _user = user;
    _status = user == null
        ? AuthStatus.Unauthenticated
        : AuthStatus.Authenticated;
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    try {
      _status = AuthStatus.Authenticating;
      notifyListeners();
      await _service.signIn(email, password);
    }
    catch(e) {
      _status = AuthStatus.Unauthenticated;
      notifyListeners();
    }
  }

  Future<void> signInAnonymously() async {
    try {
      _status = AuthStatus.Authenticating;
      notifyListeners();
      await _service.signInAnonymously();
    }
    catch(e) {
      _status = AuthStatus.Unauthenticated;
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      _status = AuthStatus.Authenticating;
      notifyListeners();
      await _service.signUp(email, password);
    }
    catch(e) {
      _status = AuthStatus.Unauthenticated;
      notifyListeners();
    }
  }

  Future signOut() async {
    _service.signOut();
    _status = AuthStatus.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future resetPassword(String email) async {
    return _service.resetPassword(email);
  }

  Future<User> signInWithGoogle() async {
    return _service.signInWithGoogle();
  }

}
