import 'package:letsattend/locator.dart';
import 'package:letsattend/services/users_service.dart';

abstract class SynchedService<T> {

  final UsersService usersService = locator<UsersService>();

  Stream<List<T>> get stream;

  void close();

}