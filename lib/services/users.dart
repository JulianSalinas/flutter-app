import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:letsattend/models/user.dart';

class UsersService {

  DatabaseReference _database = FirebaseDatabase.instance.reference();

  Future<User> getUserById(String id) async {

    DataSnapshot snapshot = await _database.child('edepa6/users/$id').once();

    if (snapshot.value == null)
      return User(uid: id, isAnonymous: true);

    final userInfo = snapshot.value;

    return User(
      uid: id,
      name: userInfo['name'],
      email: userInfo['email'],
      photoUrl: userInfo['photoUrl'],
    );

  }

}
