import 'dart:async';
import 'package:letsattend/locator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:letsattend/services/auth/auth_with_firebase.dart';
import 'package:letsattend/services/synched/synched_service.dart';

abstract class DatabaseService<T> extends SynchedService<T> {

  final AuthWithFirebase auth = locator<AuthWithFirebase>();

  final DatabaseReference database = FirebaseDatabase.instance.reference();

  final StreamController<List<T>> controller = StreamController();

  Future<T> castSnapshot(DataSnapshot snapshot);

  DateTime castMilliseconds(int milliseconds){
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  Map getData(DataSnapshot snapshot) {
    return { 'key': snapshot.key, ...snapshot.value};
  }

  @override
  void close() => controller.close();

  @override
  Stream<List<T>> get stream => controller.stream;

}
