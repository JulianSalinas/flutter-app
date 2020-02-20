import 'package:letsattend/models/user.dart';
import 'package:letsattend/models/payload.dart';

abstract class AuthService {

  Future<User> get user;

  Stream<User> get onAuthStateChanged;

  Future<AuthPayload> signIn(String email, String password);

  Future<AuthPayload> signInAnonymously();

  Future<AuthPayload> signUp(String email, String password);

  Future<AuthPayload> signInWithGoogle();

  Future<AuthPayload> resetPassword(String email);

  Future<void> signOut();

}
