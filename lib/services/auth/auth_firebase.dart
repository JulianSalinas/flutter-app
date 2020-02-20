import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:letsattend/models/user.dart';
import 'package:letsattend/services/auth/auth_google.dart';
import 'package:letsattend/models/payload.dart';
import 'package:letsattend/services/auth/auth_service.dart';

class AuthFirebase extends AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _castFirebaseUser(FirebaseUser user) {
    return user == null ? null : User.fromFirebase(user);
  }

  @override
  Future<User> get user async {
    final user = await _auth.currentUser();
    return _castFirebaseUser(user);
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _auth.onAuthStateChanged.map(_castFirebaseUser);
  }

  @override
  Future<AuthPayload> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthPayload(user: _castFirebaseUser(result.user));
    } on PlatformException catch (error) {
      return AuthPayload(errorCode: error.code);
    }
  }

  @override
  Future<AuthPayload> signUp(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthPayload(user: _castFirebaseUser(result.user));
    } on PlatformException catch (error) {
      return AuthPayload(errorCode: error.code);
    }
  }

  @override
  Future<AuthPayload> signInAnonymously() async {
    try {
      final result = await _auth.signInAnonymously();
      return AuthPayload(user: _castFirebaseUser(result.user));
    } on PlatformException catch (error) {
      return AuthPayload(errorCode: error.code);
    }
  }

  @override
  Future<AuthPayload> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return AuthPayload();
    } on PlatformException catch (error) {
      return AuthPayload(errorCode: error.code);
    }
  }

  Future<AuthPayload> signInWithGoogle() async {
    try {
      AuthGoogle authGoogle = AuthGoogle();
      final result = await authGoogle.signInWithGoogle();
      return AuthPayload(user: _castFirebaseUser(result.user));
    } on PlatformException catch (error) {
      return AuthPayload(errorCode: error.code);
    }
  }

  @override
  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _auth.signOut();
    return Future.delayed(Duration.zero);
  }

}
