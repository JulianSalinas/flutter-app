import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:letsattend/models/user.dart';

class UsersService {

  DatabaseReference database = FirebaseDatabase.instance.reference();

  Future<User> getUser(String key) async {

    DataSnapshot snapshot = await database
        .child('users')
        .child(key).once();

    if (snapshot.value == null)
      return User(id: key, isAnonymous: true);

    final data = snapshot.value;

    return User(
      id: key,
      name: data['username'],
      email: data['email'],
      photoUrl: data['photoUrl'],
    );
  }

  Future<void> setUser(User user) async {
    return database
        .child('users')
        .child(user.id).set(user.toJson());
  }

}
