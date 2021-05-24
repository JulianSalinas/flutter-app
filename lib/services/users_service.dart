import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:letsattend/models/user.dart';

class UsersService {

  /// Database to get users' information
  final DatabaseReference database = FirebaseDatabase.instance.reference();

  /// It is called when new user signs up
  Future<void> setUser(AppUser user) async {
    return database.child('users')
        .child(user.key)
        .set(user.toJson());
  }

  /// To get users from the chat using their IDs
  Future<AppUser> getUser(String key) async {

    DataSnapshot snapshot = await database
        .child('users')
        .child(key)
        .once();

    if (snapshot.value == null) {
      return AppUser(key: key, isAnonymous: true);
    }

    return AppUser(
      key: key,
      name: snapshot.value['username'],
      email: snapshot.value['email'],
      photoUrl: snapshot.value['photoUrl'],
      allowPhoto: snapshot.value['allowPhoto'],
    );
  }
}
