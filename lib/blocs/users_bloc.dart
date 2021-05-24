import 'package:letsattend/locator.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/services/users_service.dart';

class UserBloc {

  final UsersService _service = locator<UsersService>();

  Future<AppUser> getUser(String key) async {
    return _service.getUser(key);
  }

  Future<void> setUser(AppUser user) async {
    return _service.setUser(user);
  }

}
