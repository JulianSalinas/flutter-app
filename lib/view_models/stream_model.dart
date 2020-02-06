import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/services/stream_service.dart';

abstract class StreamModel<T extends StreamService> with ChangeNotifier {

  final T _service = locator<T>();

  dynamic _collection;

  dynamic get collection {
    return _collection;
  }

  StreamController<dynamic> _controller = StreamController();

  StreamController<dynamic> get controller {
    return _controller;
  }

  StreamModel() {
    _service.stream.listen(update);
  }

  void update(dynamic collection) async {
    _collection = collection;
  }

  void notify(dynamic collection) {
    _controller.add(collection.toList());
  }

  Stream<dynamic> get stream {
    return controller.stream;
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

}
