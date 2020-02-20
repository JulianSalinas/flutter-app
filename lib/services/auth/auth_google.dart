import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthGoogle {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AuthResult> signInWithGoogle() async {

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

    return _auth.signInWithCredential(credential);

  }
  
}