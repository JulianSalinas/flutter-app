import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/services/auth/auth_service.dart';

class FirebaseAuthService extends AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<User> get user async {
    return User.fromFirebase(await _auth.currentUser());
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _auth.onAuthStateChanged.map((user) => User.fromFirebase(user));
  }

  Future<User> startSign(String email, String password, Function get) async {
    final result = await get(
      email: email,
      password: password,
    );
    return result.user == null ? null : User.fromFirebase(result.user);
  }

  @override
  Future<User> signIn(String email, String password) async {
    return startSign(email, password, _auth.signInWithEmailAndPassword);
  }

  @override
  Future<User> signInAnonymously() async {
    final result = await _auth.signInAnonymously();
    return result.user == null ? null : User.fromFirebase(result.user);
  }

  @override
  Future<User> signUp(String email, String password) async {
    return startSign(email, password, _auth.createUserWithEmailAndPassword);
  }

  @override
  Future resetPassword(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future<User> signInWithGoogle() async {

    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      return throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }

    final googleAuth = await googleUser.authentication;

    if (googleAuth.accessToken == null || googleAuth.idToken == null) {
      return throw PlatformException(
        code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
        message: 'Missing Google Auth Token',
      );
    }

    final credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    final result = await _auth.signInWithCredential(credential);
    return User.fromFirebase(result.user);
  }

  @override
  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    return _auth.signOut();
  }

}
