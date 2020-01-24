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

  Speaker({
    this.about,
    this.country,
    this.university,
    @required this.key,
    @required this.name,
  });

  Color get color {
    return getColorFor(name, FlatUI.values);
  }

  String get letter {
    return initials[0];
  }

  String get initials {
    return getInitialsFrom(name);
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
    return '${name ?? ''} ${country ?? '' } ${university ?? ''}';
  }

}
