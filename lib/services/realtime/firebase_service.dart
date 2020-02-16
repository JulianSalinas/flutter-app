import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:letsattend/services/realtime/stream_service.dart';

abstract class FirebaseService<T> extends StreamService<T> {
  
  String get path;
  List<T> _collection = [];

  StreamSubscription _addSubscription;
  StreamSubscription _changeSubscription;
  StreamSubscription _removeSubscription;

  DatabaseReference _database = FirebaseDatabase.instance.reference();
  StreamController<List<T>> _controller = StreamController();

  FirebaseService(){
    final reference = _database.child(path);
    _addSubscription = reference.onChildAdded.listen(onChildAdded);
    _changeSubscription = reference.onChildChanged.listen(onChildChanged);
    _removeSubscription = reference.onChildRemoved.listen(onChildRemoved);
  }

  T fromFirebase(Event data);

  void onChildAdded(Event data) {
    _collection.add(fromFirebase(data));
    _controller.add(_collection);
  }

  void onChildChanged(Event data) {
    T value = fromFirebase(data);
    int index = _collection.indexOf(value);
    _collection.removeAt(index);
    _collection.insert(index, value);
    _controller.add(_collection);
  }

  void onChildRemoved(Event data) {
    _collection.remove(fromFirebase(data));
    _controller.add(_collection);
  }

  void addChild(dynamic data) async {
    final reference = _database.child(path);
    await reference.push().set(data);
  }

  @override
  void close() {
    _addSubscription.cancel();
    _changeSubscription.cancel();
    _removeSubscription.cancel();
    _controller.close();
  }

  @override
  Stream<List<T>> get stream {
    return _controller.stream;
  }

}
