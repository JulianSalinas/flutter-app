import 'dart:async';
import 'package:letsattend/services/stream_service.dart';
import 'package:letsattend/shared/utils.dart';
import 'package:letsattend/view_models/stream_model.dart';

class FilterableModel<T extends StreamService> extends StreamModel<T> {

  String _filter;
  Timer _typingTimer;

  void search() async {
    notify(await collection.where(isSearched).toList());
  }

  @override
  void update(dynamic collection) async {
    super.update(collection);
    search();
  }

  set filter(String filter) {
    _filter = filter.toLowerCase();
    bool cancel = _typingTimer != null && _typingTimer.isActive;
    if(cancel) _typingTimer.cancel();
    _typingTimer = Timer(Duration(milliseconds: 400), search);
  }

  @override
  void notify(dynamic collection) {
    controller.add(collection.toList());
  }

  bool isSearched(Object item) =>
      _filter == null ||
      _filter.isEmpty ||
      containsFilter(_filter, item.toString());

}
