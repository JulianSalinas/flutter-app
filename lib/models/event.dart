import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/models/speaker.dart';

class Event {

  final String key;
  final String title;
  final String type;
  final Timestamp end;
  final Timestamp start;

  final String code;
  final String location;
  final String description;

  bool isFavorite;
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
    this.isFavorite = false,
  });

  factory Event.fromMap(String key, Map snapshot) => Event(
    key: key,
    title: snapshot['title'] ?? 'SIN TÍTULO',
    type: snapshot['type'] ?? 'DESCONOCIDO',
    end: snapshot['end'],
    start: snapshot['start'],
    code: snapshot['code'] ?? '#',
    location: snapshot['location'] ?? 'DESCONOCIDA',
    description: snapshot['description'],
    isFavorite: false,
  );

  factory Event.fromFirestore(DocumentSnapshot snapshot) {
    return Event.fromMap(snapshot.documentID, snapshot.data);
  }

  static Map<String, Color> colors = {
    'CONFERENCIA' : Color(0xff21bf73),
    'TALLER': Color(0xfff5587b), // Approved
    'PONENCIA': Color(0xffff8a5c), // Approved
    'FERIA_EDEPA': Color(0xff9399ff),
  };

  Color get color {
    return Event.colors[type] ?? SharedColors.kashmir;
  }

  String get image {
    return 'assets/tec_edificio_a4.jpg';
  }

  @override
  String toString() {
    return 'Event: $type $code $title';
  }

}
