import 'dart:async';
import 'package:letsattend/locator.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/services/users.dart';

class UserModel {

  final UsersService _service = locator<UsersService>();

  Future<User> getUserById(String id) async {
    return _service.getUserById(id);
  }

}
