import 'dart:async';
import 'package:letsattend/shared/utils.dart';
import 'package:letsattend/services/realtime/stream_service.dart';
import 'package:letsattend/view_models/collections/orderable_model.dart';

class FilterableModel<T extends StreamService> extends OrderableModel<T> {

  String _filter;
  Timer _typingTimer;

  set filter(String filter) {
    _filter = filter.toLowerCase();
    if(_timerShouldCancel()) _typingTimer.cancel();
    _typingTimer = Timer(Duration(milliseconds: 400), search);
  }

  bool _timerShouldCancel(){
    return _typingTimer != null && _typingTimer.isActive;
  }

  void search() async {
    notify(collection.where(isSearched).toList());
  }

  bool isSearched(Object item) =>
      _filter == null ||
      _filter.isEmpty ||
      containsFilter(_filter, item.toString());

}
