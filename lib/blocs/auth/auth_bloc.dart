import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:letsattend/locator.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/models/auth/auth_payload.dart';
import 'package:letsattend/services/auth/auth_status.dart';
import 'package:letsattend/services/auth/auth_with_firebase.dart';

class AuthBloc with ChangeNotifier {

  final AuthWithFirebase _service = locator<AuthWithFirebase>();

  User _user;
  User get user => _user;

  AuthStatus _status = AuthStatus.Uninitialized;
  AuthStatus get status => _status;

  AuthBloc() {
    _service.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User user) async {
    _user = user;
    _status = user == null
        ? AuthStatus.Unauthenticated
        : AuthStatus.Authenticated;
    notifyListeners();
  }

  void _validatePayload(AuthPayload payload){
    if(payload.hasError){
      _status = AuthStatus.Unauthenticated;
      notifyListeners();
    }
  }

  Future<AuthPayload> signIn(String email, String password) async {
    _status = AuthStatus.Authenticating;
    notifyListeners();
    final payload = await _service.signIn(email, password);
    _validatePayload(payload);
    return payload;
  }

  Future<AuthPayload> signInAnonymously() async {
    _status = AuthStatus.Authenticating;
    notifyListeners();
    final payload = await _service.signInAnonymously();
    _validatePayload(payload);
    return payload;
  }

  Future<AuthPayload> signUp(String email, String password) async {
    _status = AuthStatus.Authenticating;
    notifyListeners();
    final payload = await _service.signUp(email, password);
    _validatePayload(payload);
    return payload;
  }

  Future<AuthPayload> signInWithGoogle() async {
    _status = AuthStatus.Authenticating;
    notifyListeners();
    final payload = await _service.signInWithGoogle();
    _validatePayload(payload);
    return payload;
  }


  Future<AuthPayload> resetPassword(String email) async {
    final payload = await _service.resetPassword(email);
    _validatePayload(payload);
    return payload;
  }

  Future<void> signOut() async {
    await _service.signOut();
    return Future.delayed(Duration.zero);
  }

}
