import 'package:letsattend/models/user.dart';

class AuthPayload {

  static const ERROR_SIGN_FAILED = 'sign_in_failed';
  static const ERROR_WRONG_PASSWORD = 'ERROR_WRONG_PASSWORD';
  static const ERROR_INVALID_EMAIL = 'ERROR_INVALID_EMAIL';
  static const ERROR_USER_NOT_FOUND = 'ERROR_USER_NOT_FOUND';
  static const ERROR_EMAIL_ALREADY_IN_USE = 'ERROR_EMAIL_ALREADY_IN_USE';
  static const ERROR_NETWORK_REQUEST_FAILED = 'ERROR_NETWORK_REQUEST_FAILED';

  final User user;
  final String errorCode;

  AuthPayload({
    this.user,
    this.errorCode
  });

  bool get hasError => errorCode != null;

}