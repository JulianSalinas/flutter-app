import 'package:flutter/material.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/models/speaker.dart';

class Event {

  final String key;

  final String title;
  final String type;
  final DateTime end;
  final DateTime start;

  final String code;
  final String location;
  final String description;

  bool isFavorite = false;
  List<Speaker> speakers = [];

  Event({
    @required this.key,
    @required this.title,
    @required this.type,
    @required this.end,
    @required this.start,
    this.code,
    this.location,
    this.description,
    this.isFavorite,
    this.speakers,
  });

  static Map<String, Color> colors = {
    'CONFERENCIA': Color(0xff21bf73),
    'TALLER': Color(0xfff5587b),
    'PONENCIA': Color(0xffff8a5c),
    'FERIA_EDEPA': Color(0xff9399ff),
  };

  Color get color {
    return Event.colors[type] ?? SharedColors.alizarin;
  }

  String get image {
    return 'assets/tec_edificio_a4.jpg';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Event && key == other.key;
  }

  @override
  int get hashCode => key.hashCode;

  @override
  String toString() {
    return 'Event: $type $code $title';
  }
}
