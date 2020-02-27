import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthGoogle {

  Future<GoogleSignInAuthentication> signInWithGoogle() async {

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

    return googleAuth;
  }
}
