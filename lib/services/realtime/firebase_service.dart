import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:letsattend/services/realtime/stream_service.dart';

abstract class FirebaseService<T> extends StreamService<T> {
  
  String get path;

  List<T> _collection = [];
  StreamSubscription _addSubscription;
  StreamController<List<T>> _controller = StreamController();

  FirebaseService(){
    final database = FirebaseDatabase.instance.reference();
    final reference = database.child(path);
    _addSubscription = reference.onChildAdded.listen(onChildAdded);
  }

  T fromFirebase(Event data);

  void onChildAdded(Event data) {
    _collection.add(fromFirebase(data));
    _controller.add(_collection);
  }

  @override
  void close() {
    _addSubscription.cancel();
    _controller.close();
  }

  @override
  Stream<List<T>> get stream {
    return _controller.stream;
  }

}
