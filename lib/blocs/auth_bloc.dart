import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:letsattend/locator.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/models/auth.dart';
import 'package:letsattend/shared/status.dart';
import 'package:letsattend/services/auth_service.dart';
import 'package:letsattend/services/users_service.dart';
import 'package:letsattend/services/auth_with_firebase.dart';

class AuthBloc with ChangeNotifier {

  final AuthService _auth = locator<AuthWithFirebase>();
  final UsersService _usersService = locator<UsersService>();

  Status status = Status.Uninitialized;

  AppUser? _currentUser;

  AppUser? get currentUser => _currentUser;

  set currentUser(currentUser) {
    _currentUser = currentUser;
    notifyListeners();
  }

  set allowPhoto(bool value) {
    _currentUser?.allowPhoto = value;
    notifyListeners();
    _usersService.setUser(currentUser!);
  }

  AuthBloc() {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(AppUser? user) async {
    _currentUser = user;
    status = user == null
        ? Status.Unauthenticated
        : Status.Authenticated;
    notifyListeners();
  }

  void _validatePayload(Auth payload){
    if(payload.hasError){
      status = Status.Unauthenticated;
      notifyListeners();
    }
  }

  Future<Auth> signIn(String email, String password) async {
    status = Status.Authenticating;
    notifyListeners();
    final payload = await _auth.signIn(email, password);
    _validatePayload(payload);
    return payload;
  }

  Future<Auth> signInAnonymously() async {
    status = Status.Authenticating;
    notifyListeners();
    final payload = await _auth.signInAnonymously();
    _validatePayload(payload);
    return payload;
  }

  Future<Auth> signUp(String email, String password) async {
    status = Status.Authenticating;
    notifyListeners();
    final payload = await _auth.signUp(email, password);
    _validatePayload(payload);
    return payload;
  }

  Future<Auth> signInWithGoogle() async {
    status = Status.Authenticating;
    notifyListeners();
    final payload = await _auth.signInWithGoogle();
    _validatePayload(payload);
    return payload;
  }

  Future<Auth> resetPassword(String email) async {
    final payload = await _auth.resetPassword(email);
    _validatePayload(payload);
    return payload;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    return Future.delayed(Duration.zero);
  }

}
