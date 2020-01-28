import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/models/speaker.dart';

class Event {

  final String key;
  final String code;

  final String title;
  final String type;
  final String location;
  final String description;

  final DateTime end;
  final DateTime start;

  /// There are assigned in the service
  List<Speaker> speakers;

  /// Is false until the value is assigned
  bool isFavorite;

  Event({
    this.code,
    this.location,
    this.description,
    @required this.key,
    @required this.title,
    @required this.type,
    @required this.start,
    @required this.end,
    @required this.isFavorite
  });

  factory Event.fromMap(String key, Map snapshot) => Event(
    key: key,
    title: snapshot['title'] ?? 'SIN TÍTULO',
    type: snapshot['type'] ?? 'DESCONOCIDO',
    start: snapshot['start'],
    end: snapshot['end'],
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
