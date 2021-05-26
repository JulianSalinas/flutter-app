import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/services/auth_with_firebase.dart';
import 'package:letsattend/services/synched_service.dart';

abstract class FirebaseService<T> extends SynchedService<T> {

  /// Let each service to get the current user's information
  final AuthWithFirebase auth = locator<AuthWithFirebase>();

  /// Let each service to use the database
  final DatabaseReference database = FirebaseDatabase.instance.reference();

  /// To create firebase query
  final String path;
  final String? orderBy;
  final String? equalTo;

  /// Holds the retrieved data
  List<T> collection = [];

  /// Subscriptions for realtime changes
  late StreamSubscription _addSubscription;
  late StreamSubscription _changeSubscription;
  late StreamSubscription _removeSubscription;

  /// Path to reach realtime database data
  FirebaseService(this.path, {this.orderBy, this.equalTo}) {
    final reference = database.child(path);

    var query = orderBy == null
        ? reference
        : reference.orderByChild(orderBy!);

    query = equalTo == null
        ? query
        : query.equalTo(equalTo);

    _addSubscription = query.onChildAdded
        .asBroadcastStream()
        .listen(onChildAdded);

    _changeSubscription = reference.onChildChanged
        .asBroadcastStream()
        .listen(onChildChanged);

    _removeSubscription = reference.onChildRemoved
        .asBroadcastStream()
        .listen(onChildRemoved);
  }

  /// Let each service return its own type for the list
  Future<T?> parse(DataSnapshot snapshot);

  Future<void> addChild(dynamic data) async {
    final reference = database.child(path);
    await reference.push().set(data);
  }

  Future<void> onChildAdded(Event data) async {
    T? value = await parse(data.snapshot);
    if (value == null) return;
    collection.add(value);
    controller.add(collection);
  }

  Future<void> onChildChanged(Event data) async {
    T? value = await parse(data.snapshot);
    if (value == null) return;
    int index = collection.indexOf(value);
    collection.removeAt(index);
    collection.insert(index, value);
    controller.add(collection);
  }

  Future<void> onChildRemoved(Event data) async {
    collection.remove(await parse(data.snapshot));
    controller.add(collection);
  }

  @override
  void close() {
    _addSubscription.cancel();
    _changeSubscription.cancel();
    _removeSubscription.cancel();
    super.close();
  }

}
