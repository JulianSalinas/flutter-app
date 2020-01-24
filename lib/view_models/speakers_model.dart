import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:letsattend/locator.dart';
import 'package:letsattend/shared/utils.dart';
import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/services/speakers_service.dart';

class SpeakersModel with ChangeNotifier {

  final SpeakersService _service = locator<SpeakersService>();
  StreamController<List<Speaker>> _controller = new StreamController();

  String _filter;
  Timer _typingTimer;

  bool _descending = true;
  List<Speaker> _speakers;

  SpeakersModel() {
    _service.createSpeakersStream().listen(update);
  }

  Future<List<Speaker>> filtered() async {
    return _speakers.where(isSearched).toList();
  }

  void update(List<Speaker> speakers) async {
    _speakers = speakers;
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

  get descending => _descending;

  set descending(bool descending) {
    _descending = descending;
    stream(_speakers);
    notifyListeners();
  }

  void stream(List<Speaker> speakers) {
    _controller.add(
      descending ? speakers.toList() : speakers.reversed.toList(),
    );
  }

  bool isSearched(Speaker speaker) =>
      _filter == null ||
      _filter.isEmpty ||
      containsFilter(_filter, speaker.toString());

  Stream<List<Speaker>> get speakers {
    return _controller.stream;
  }

}
