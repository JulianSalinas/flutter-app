import 'package:flutter/foundation.dart';

abstract class AuthService with ChangeNotifier {

  Future signInWithEmailAndPassword(String email, String password);

  Future createUserWithEmailAndPassword(String email, String password);

  Future endPasswordResetEmail(String email);

}
