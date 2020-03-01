import 'package:letsattend/models/user.dart';

class Auth {

  final User user;
  final String errorCode;

  const Auth({
    this.user,
    this.errorCode
  });

  bool get hasError => errorCode != null;

  @override
  String toString() {
    return 'Auth{ user: $user, errorCode: $errorCode }';
  }

}