import 'package:letsattend/models/user.dart';

class AuthPayload {

  static const ERROR_WRONG_PASSWORD = 'ERROR_WRONG_PASSWORD';
  static const ERROR_INVALID_EMAIL = 'ERROR_INVALID_EMAIL';
  static const ERROR_USER_NOT_FOUND = 'ERROR_USER_NOT_FOUND';
  static const ERROR_EMAIL_ALREADY_IN_USE = 'ERROR_EMAIL_ALREADY_IN_USE';

  final User user;
  final String errorCode;

  AuthPayload({
    this.user,
    this.errorCode
  });

  bool get hasError => errorCode != null;

}