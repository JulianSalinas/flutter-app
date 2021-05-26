import 'dart:async';
import 'package:letsattend/blocs/synched_bloc.dart';
import 'package:letsattend/services/synched_service.dart';

class OrderableBloc<T extends SynchedService> extends SynchedBloc<T> {

  final StreamController controller = StreamController();

  List<dynamic> collection = List.empty();

  bool _descending = true;
  bool get descending => _descending;

  set descending(bool descending) {
    _descending = descending;
    notify(collection);
    notifyListeners();
  }

  late StreamSubscription _subscription;

  OrderableBloc() {
    _subscription = service.stream
        .asBroadcastStream()
        .listen(update);
  }
  
  void update(List<dynamic> listened){
    collection = listened;
    notify(collection);
  }

  void notify(dynamic collection) {
    controller.add(descending
        ? collection.toList()
        : collection.reversed.toList(),
    );
  }

  Stream<dynamic> get stream {
    return controller.stream.asBroadcastStream();
  }

  @override
  void dispose() {
    controller.close();
    _subscription.cancel();
    super.dispose();
  }

}
