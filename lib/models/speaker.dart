import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letsattend/models/person.dart';

class Speaker extends Person {

  final String key;

  final String name;
  final String about;
  final String country;
  final String university;

  bool isPartial;
  DocumentReference reference;

  Speaker({
    @required this.key,
    @required this.name,
    this.about,
    this.country,
    this.university,
    this.reference,
    this.isPartial = false,
  }) : super(name == null ? '#': name);

  factory Speaker.partial(String key, Map snapshot) {
    snapshot['key'] = key;
    Speaker speaker = Speaker.fromMap(snapshot);
    speaker.isPartial = true;
    speaker.reference = snapshot['reference'];
    return speaker;
  }

  factory Speaker.fromMap(Map snapshot) {
    return Speaker(
      key: snapshot['key'],
      name: snapshot['completeName'],
      about: snapshot['about'],
      country: snapshot['country'],
      university: snapshot['university'],
    );
  }

  @override
  String toString() {
    return 'Speaker: ${name ?? ''} ${country ?? '' } ${university ?? ''}';
  }

}
