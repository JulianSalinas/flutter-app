// ignore: import_of_legacy_library_into_null_safe
import 'package:uuid/uuid.dart';
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
  AppUser get user {
    final user = _auth.currentUser;
    return _parseUser(user);
  }

  @override
  Stream<AppUser> get onAuthStateChanged {
    return _auth.authStateChanges().map(_parseUser);
  }

  AppUser _parseUser(User? user) {

    final emptyUser = AppUser(
      key: Uuid().v1().toString(),
      isLogged: false,
    );

    if (user == null) return emptyUser;

    return AppUser(
      key: user.uid,
      name: user.displayName ?? "unknown",
      email: user.email,
      photoUrl: user.photoURL,
      isAnonymous: user.isAnonymous,
      isLogged: true,
    );

  }

  @override
  Future<Auth> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      AppUser user = _parseUser(result.user);
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
      AppUser user = _parseUser(result.user);
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
      AppUser user = _parseUser(result.user);
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

      final credential = GoogleAuthProvider.credential(
        idToken: signInAuth.idToken,
        accessToken: signInAuth.accessToken,
      );

      final result = await _auth.signInWithCredential(credential);
      return Auth(user: _parseUser(result.user));

    } on PlatformException catch (error) {
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
