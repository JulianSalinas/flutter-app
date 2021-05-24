import 'package:letsattend/locator.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/models/auth.dart';
import 'package:letsattend/services/users_service.dart';

abstract class AuthService {

  final UsersService usersService = locator<UsersService>();

  AppUser get user;
  Stream<AppUser> get onAuthStateChanged;

  Future<Auth> signInWithGoogle();
  Future<Auth> signInAnonymously();
  Future<Auth> signIn(String email, String password);
  Future<Auth> signUp(String email, String password);
  Future<Auth> resetPassword(String email);
  Future<void> signOut();

}
