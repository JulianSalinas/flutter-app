import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/colors.dart';
import 'package:letsattend/models/speaker.dart';

class Event {

  // Provided by database
  String key;

  // Provided by user
  String code;

  String title;
  String type;
  String location;
  String description;

  // Scheduled event
  DateTime end;
  DateTime start;

  List<Speaker> people;
  bool isFavorite;

  Event({
    this.key,
    this.title,
    this.type,
    this.location,
    this.code,
    this.end,
    this.start,
    this.people,
    this.isFavorite
  });

  Event.empty();

  Color getColor(){
//    if (type == 'PONENCIA')
//      return UIColors.ponencia;
//    else if (type == 'CONFERENCIA')
//      return UIColors.conferencia;
//    else if (type == 'TALLER')
//      return UIColors.taller;
//    else if (type == 'FERIA')
//      return UIColors.feria;
//    else
//      return UIColors.merienda;
    return Colors.green;
  }

  String getImage(){
    return 'assets/tec_edificio_a4.jpg';
  }

}
