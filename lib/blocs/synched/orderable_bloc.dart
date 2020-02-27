import 'dart:async';
import 'package:letsattend/services/synched/synched_service.dart';
import 'package:letsattend/blocs/synched/synched_bloc.dart';

class OrderableBloc<T extends SynchedService> extends SynchedBloc<T> {

  List<dynamic> _collection;

  List<dynamic> get collection => _collection;
  
  bool _descending = true;

  get descending => _descending;

  set descending(bool descending) {
    _descending = descending;
    notify(collection);
    notifyListeners();
  }
  
  StreamController _controller = StreamController();

  StreamController get controller => _controller;

  StreamSubscription _subscription;
  
  OrderableBloc() {
    _subscription = service.stream.listen(update);
  }
  
  void update(List<dynamic> collection){
    _collection = collection;
    notify(collection);
  }

  void notify(dynamic collection) {
    _controller.add(descending
        ? collection.toList()
        : collection.reversed.toList(),
    );
  }

  Stream<dynamic> get stream {
    return _controller.stream;
  }

  @override
  void dispose() {
    _controller.close();
    _subscription.cancel();
    super.dispose();
  }

}
