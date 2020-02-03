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

  Color getColor(){
    switch(this.type){
      case 'CONFERENCIA':
        return SharedColors.greenSea;
      case 'TALLER':
        return SharedColors.pomegranate;
      case 'PONENCIA':
        return SharedColors.wisteria;
      default:
        return SharedColors.facebook;
    }
  }

  String getImage(){
    return 'assets/tec_edificio_a4.jpg';
  }

  @override
  String toString() {
    return '$type $code $title';
  }

}
