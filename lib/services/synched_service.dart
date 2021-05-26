import 'dart:async';

/// Implemented by services which provide a list in realtime
abstract class SynchedService<T> {

  final StreamController<List<T>> controller = StreamController();

  Stream<List<T>> get stream => controller.stream.asBroadcastStream();

  void close() {
    controller.close();
  }

}