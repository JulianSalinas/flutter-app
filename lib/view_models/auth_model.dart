import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/services/auth/firebase_auth_service.dart';

class AuthModel with ChangeNotifier {

  final FirebaseAuthService _service = locator<FirebaseAuthService>();
  final StreamController<User> _controller = StreamController<User>.broadcast();

  AuthModel() {
    _service.onAuthStateChanged.listen(
      _controller.add,
      onError: _controller.addError,
    );
  }

  Future<User> get user async {
    return _service.user;
  }

  Future<User> signIn(String email, String password) async {
    return _service.signIn(email, password);
  }

  Future<User> signInAnonymously() async {
    return _service.signInAnonymously();
  }

  Future<User> signUp(String email, String password) async {
    return _service.signUp(email, password);
  }

  Future resetPassword(String email) async {
    return _service.resetPassword(email);
  }

  Future<User> signInWithGoogle() async {
    return _service.signInWithGoogle();
  }

  Future<void> signOut() async {
    return _service.signOut();
  }

  Stream<User> get onAuthChanged => _controller.stream;

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

}
