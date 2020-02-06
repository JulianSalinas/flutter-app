import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:letsattend/shared/utils.dart';
import 'package:letsattend/shared/colors.dart';

class Speaker {

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
  });

  Color get color {
    return getColorFor(name, SharedColors.flat);
  }

  String get initial {
    return initials[0];
  }

  String get initials {
    return getInitialsFrom(name);
  }

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
