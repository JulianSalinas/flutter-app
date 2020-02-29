import 'package:letsattend/models/user.dart';

class AuthPayload {

  final User user;
  final String errorCode;

  AuthPayload({
    this.user,
    this.errorCode
  });

  bool get hasError => errorCode != null;

}