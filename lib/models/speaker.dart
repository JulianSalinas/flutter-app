import 'package:letsattend/models/person.dart';

class Speaker extends Person {

  final String key;
  final String name;
  final String? about;
  final String? country;
  final String? university;
  Map? eventKeys;

  Speaker({
    required this.key,
    this.name = "unknown",
    this.about,
    this.country,
    this.university,
    this.eventKeys,
  }) : super(name);

  @override
  int get hashCode => key.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Speaker && key == other.key;
  }

  @override
  String toString() {
    return 'Speaker{ key: $key, name: $name, country: $country }';
  }

}
