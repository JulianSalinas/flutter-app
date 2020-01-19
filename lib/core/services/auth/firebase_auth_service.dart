import 'package:flutter/foundation.dart' as firebase_service;
import 'package:letsattend/core/services/auth/auth_service.dart';

class FirebaseAuthService extends AuthService {

  Future signInWithEmailAndPassword(String email, String password) async {
    notifyListeners();
  }

  Future createUserWithEmailAndPassword(String email, String password) async {
    notifyListeners();
  }

  Future endPasswordResetEmail(String email) async {
    notifyListeners();
  }

}
