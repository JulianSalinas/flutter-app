import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/services/realtime/stream_service.dart';

abstract class StreamModel<T extends StreamService> with ChangeNotifier {

  final T _service = locator<T>();

  T get service => _service;

  Stream<dynamic> get stream {
    return _service.stream;
  }

  @override
  void dispose() {
    _service?.close();
    super.dispose();
  }

}
