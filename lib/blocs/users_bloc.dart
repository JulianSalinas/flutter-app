import 'dart:async' as UsersBloc;
import 'package:letsattend/locator.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/services/users_service.dart';

class UserBlocs {

  final UsersService _service = locator<UsersService>();

  UsersBloc.Future<User> getUserById(String id) async {
    return _service.getUserById(id);
  }

}
