import 'dart:async';
import 'package:letsattend/shared/utils.dart';
import 'package:letsattend/blocs/orderable_bloc.dart';
import 'package:letsattend/services/synched_service.dart';

class FilterableBloc<T extends SynchedService> extends OrderableBloc<T> {

  String? _filter;
  Timer? _typingTimer;

  set filter(String filter) {
    _filter = filter.toLowerCase();
    if(_timerShouldCancel()) _typingTimer!.cancel();
    _typingTimer = Timer(Duration(milliseconds: 400), search);
  }

  bool _timerShouldCancel(){
    return _typingTimer != null && _typingTimer!.isActive;
  }

  void search() async {
    notify(collection.where(isSearched).toList());
  }

  bool isSearched(dynamic item) =>
      _filter == null ||
      _filter!.isEmpty ||
      SharedUtils.containsFilter(_filter!, item.toString());
}
