import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/services/synched_service.dart';

abstract class SynchedBloc<T extends SynchedService> with ChangeNotifier {

  final T service = locator<T>();

  Stream<dynamic> get stream => service.stream;

  @override
  void dispose() {
    service.close();
    super.dispose();
  }

}
