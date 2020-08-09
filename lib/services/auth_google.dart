import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:letsattend/shared/codes.dart';

class AuthGoogle {

  final abortedByUserException = PlatformException(
    code: Codes.abortedByUser,
    message: 'Sign in aborted by user',
  );

  final missingGoogleAuthTokenException = PlatformException(
    code: Codes.missingGoogleAuthToken,
    message: 'Missing Google Auth Token',
  );

  Future<GoogleSignInAuthentication> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null)
      return throw abortedByUserException;

    final googleAuth = await googleUser.authentication;

    if (googleAuth.accessToken == null
        || googleAuth.idToken == null)
      return throw missingGoogleAuthTokenException;

    return googleAuth;
  }

}
