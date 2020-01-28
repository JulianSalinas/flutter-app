import 'dart:async';
import 'package:flutter/foundation.dart';
import "package:collection/collection.dart";
import 'package:jiffy/jiffy.dart';

import 'package:letsattend/locator.dart';
import 'package:letsattend/shared/utils.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/services/events_service.dart';

class ScheduleModel with ChangeNotifier {

  final EventsService _service = locator<EventsService>();

  StreamController<Map<dynamic, List<Event>>> _controller =
      new StreamController();

  String _filter;
  Timer _typingTimer;

  List<Event> _events;
  bool _orderedByType = false;

  get orderedByType => _orderedByType;

  set orderedByType(bool orderedByType) {
    _orderedByType = orderedByType;
    stream(_events);
    notifyListeners();
  }

  ScheduleModel() {
    _service.createStream().listen(update);
  }

  Future<List<Event>> filtered() async {
    return _events.where(isSearched).toList();
  }

  void update(List<Event> speakers) async {
    _events = speakers;
    search();
  }

  set filter(String filter) {
    _filter = filter.toLowerCase();

    if (_typingTimer != null && _typingTimer.isActive) _typingTimer.cancel();

    _typingTimer = Timer(Duration(milliseconds: 400), search);
  }

  void search() async {
    stream(await filtered());
  }

  void stream(List<Event> events) {
    Map<dynamic, List<Event>> group = _orderedByType
        ? groupBy(events, (event) => event.type)
        : groupBy(events, (event) => Jiffy(event.start).startOf('day'));
    _controller.add(group);
  }

  bool isSearched(Event speaker) =>
      _filter == null ||
      _filter.isEmpty ||
      containsFilter(_filter, speaker.toString());

  Stream<Map<dynamic, List<Event>>> get events {
    return _controller.stream;
  }

}
