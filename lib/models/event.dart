import 'package:letsattend/models/speaker.dart';

class Event {

  final String key;
  final String code;

  final String type;
  final String title;
  final String description;

  final DateTime start;
  final DateTime end;

  final String image;
  final String location;

  bool isFavorite;
  List<Speaker> speakers;

  Event({
    this.key,
    this.code,
    this.type,
    this.title,
    this.description,
    this.start,
    this.end,
    this.image,
    this.location,
    this.isFavorite,
    this.speakers,
  });

  @override
  int get hashCode => key.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Event && key == other.key;
  }

  @override
  String toString() {
    return 'Event{ code: $code, type: $type, title: $title }';
  }

}
