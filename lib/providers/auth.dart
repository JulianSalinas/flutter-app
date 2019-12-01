import 'package:flutter/foundation.dart';

class Auth with ChangeNotifier {

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
