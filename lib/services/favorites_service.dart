import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

import 'package:letsattend/locator.dart';
import 'package:letsattend/services/auth_with_firebase.dart';

class FavoritesService {

  final AuthWithFirebase auth = locator<AuthWithFirebase>();

  final DatabaseReference database = FirebaseDatabase.instance.reference();

  Future<bool> isFavorite(String eventKey) async {

    final user = auth.user;
    final snapshot = await database
        .child('edepa6')
        .child('favorites')
        .child(user.key)
        .child(eventKey).once();

    return snapshot.value != null;
  }

  Future<void> setFavorite(String eventKey, bool value) async {

    final user = auth.user;
    final reference = database
        .child('edepa6')
        .child('favorites')
        .child(user.key)
        .child(eventKey);

    return value ? reference.set(true) : reference.remove();
  }

}
