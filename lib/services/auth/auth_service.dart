import 'package:letsattend/models/user.dart';

abstract class AuthService {

  Future<User> get user;

  Stream<User> get onAuthStateChanged;

  Future<User> signIn(String email, String password);

  Future<User> signInAnonymously();

  Future<User> signUp(String email, String password);

  Future<void> resetPassword(String email);

  Future<void> signOut();

}
