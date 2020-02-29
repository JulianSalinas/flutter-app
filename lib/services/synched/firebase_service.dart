import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:letsattend/services/synched/database_service.dart';

abstract class FirebaseService<T> extends DatabaseService<T> {

  final String path;
  final String orderBy;

  List<T> collection = [];
  StreamSubscription _addSubscription;
  StreamSubscription _changeSubscription;
  StreamSubscription _removeSubscription;

  FirebaseService(this.path, {this.orderBy}) {
    final reference = database.child(path);

    final query = orderBy == null
        ? reference
        : reference.orderByChild(orderBy);

    _addSubscription = query.onChildAdded.listen(onChildAdded);
    _changeSubscription = reference.onChildChanged.listen(onChildChanged);
    _removeSubscription = reference.onChildRemoved.listen(onChildRemoved);
  }

  Future<void> onChildAdded(Event data) async {
    collection.add(await castSnapshot(data.snapshot));
    controller.add(collection);
  }

  Future<void> onChildChanged(Event data) async {
    T value = await castSnapshot(data.snapshot);
    int index = collection.indexOf(value);
    collection.removeAt(index);
    collection.insert(index, value);
    controller.add(collection);
  }

  Future<void> onChildRemoved(Event data) async {
    collection.remove(await castSnapshot(data.snapshot));
    controller.add(collection);
  }

  void addChild(dynamic data) async {
    final reference = database.child(path);
    await reference.push().set(data);
  }

  @override
  void close() {
    _addSubscription.cancel();
    _changeSubscription.cancel();
    _removeSubscription.cancel();
    super.close();
  }
}
