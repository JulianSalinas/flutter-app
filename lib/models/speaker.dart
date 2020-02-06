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
    Speaker speaker = Speaker.fromMap(key, snapshot);
    speaker.isPartial = true;
    speaker.reference = snapshot['reference'];
    return speaker;
  }

  factory Speaker.fromMap(String key, Map snapshot) => Speaker(
    key: key,
    name: snapshot['name'],
    about: snapshot['about'],
    country: snapshot['country'],
    university: snapshot['university'],
  );

  factory Speaker.fromFirestore(DocumentSnapshot snapshot) {
    return Speaker.fromMap(snapshot.documentID, snapshot.data);
  }

  @override
  String toString() {
    return 'Speaker: ${name ?? ''} ${country ?? '' } ${university ?? ''}';
  }

}
