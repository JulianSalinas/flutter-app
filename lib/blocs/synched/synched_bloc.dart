import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/services/synched/synched_service.dart';

abstract class SynchedBloc<T extends SynchedService> with ChangeNotifier {

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
