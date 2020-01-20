import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:letsattend/locator.dart';
import 'package:letsattend/models/filter.dart';
import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/services/speakers_service.dart';

class SpeakersController with ChangeNotifier {

  Filter _filter = Filter();

  final SpeakersService _service = locator<SpeakersService>();

  set filter(String term) {
    _filter.term = term;
    print('Speakers: Filter changed to: $term');
    notifyListeners();
  }

  get asc => _filter.asc;

  set asc(bool asc) {
    _filter.asc = asc;
    String order = asc ? 'DESC' : 'ASC';
    print('Speakers: Order changed to: $order');
    notifyListeners();
  }

  bool applyFilter(Speaker speaker) =>
      _filter.term == null ||
      _filter.term.isEmpty ||
      (speaker.university ?? speaker.country).startsWith(_filter.term);

  Stream<List<Speaker>> get speakers {
    if(_filter.apply == null)
      _filter.apply = applyFilter;
    return _service.getSpeakersStream(_filter);
  }

}
