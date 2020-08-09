import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:letsattend/models/user.dart';
import 'package:letsattend/models/auth.dart';
import 'package:letsattend/services/auth_google.dart';
import 'package:letsattend/services/auth_service.dart';

class AuthWithFirebase extends AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<User> get user async {
    final user = await _auth.currentUser();
    return _parseUser(user);
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _auth.onAuthStateChanged.map(_parseUser);
  }

  User _parseUser(FirebaseUser user) {
    return user == null ? null : User(
      key: user.uid,
      name: user.displayName,
      email: user.email,
      photoUrl: user.photoUrl,
      isAnonymous: user.isAnonymous,
    );
  }

  @override
  Future<Auth> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = _parseUser(result.user);
      await usersService.setUser(user);
      return Auth(user: user);
    } on PlatformException catch (error) {
      return Auth(errorCode: error.code);
    }
  }

  @override
  Future<Auth> signUp(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = _parseUser(result.user);
      await usersService.setUser(user);
      return Auth(user: user);
    } on PlatformException catch (error) {
      return Auth(errorCode: error.code);
    }
  }

  @override
  Future<Auth> signInAnonymously() async {
    try {
      final result = await _auth.signInAnonymously();
      User user = _parseUser(result.user);
      await usersService.setUser(user);
      return Auth(user: user);
    } on PlatformException catch (error) {
      return Auth(errorCode: error.code);
    }
  }

  @override
  Future<Auth> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return Auth();
    } on PlatformException catch (error) {
      return Auth(errorCode: error.code);
    }
  }

  @override
  Future<Auth> signInWithGoogle() async {
    try {
      AuthGoogle authGoogle = AuthGoogle();
      final signInAuth = await authGoogle.signInWithGoogle();
      final credential = GoogleAuthProvider.getCredential(
        idToken: signInAuth.idToken,
        accessToken: signInAuth.accessToken,
      );
      final result = await _auth.signInWithCredential(credential);
      return Auth(user: _parseUser(result.user));
    }
    on PlatformException catch (error) {
      return Auth(errorCode: error.code);
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
