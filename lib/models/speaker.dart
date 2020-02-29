import 'package:flutter/material.dart';
import 'package:letsattend/models/person.dart';

class Speaker extends Person {
  final String key;

  final String name;
  final String about;
  final String country;
  final String university;

  Speaker({
    @required this.key,
    @required this.name,
    this.about,
    this.country,
    this.university,
  }) : super(name == null ? '#' : name);

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Speaker && key == other.key;
  }

  @override
  int get hashCode => key.hashCode;

  @override
  String toString() {
    return 'Speaker: ${name ?? ''} ${country ?? ''} ${university ?? ''}';
  }
}
