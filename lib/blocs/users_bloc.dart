import 'package:letsattend/locator.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/services/users_service.dart';

class UserBloc {

  final UsersService _service = locator<UsersService>();

  Future<User> getUser(String key) async {
    return _service.getUser(key);
  }

  Future<void> setUser(User user) async {
    return _service.setUser(user);
  }

}
