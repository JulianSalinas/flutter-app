import 'package:flutter/cupertino.dart';
import 'package:letsattend/colors/ui_colors.dart';
import 'package:letsattend/models/person.dart';

class Event {

  // Provided by database
  String id;

  // Provided by user
  String code;

  String title;
  String type;
  String location;
  String description;

  // Scheduled event
  DateTime end;
  DateTime start;

  List<Person> people;
  bool isFavorite;

  Event({
    this.id,
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
    if (type == 'PONENCIA')
      return UIColors.ponencia;
    else if (type == 'CONFERENCIA')
      return UIColors.conferencia;
    else if (type == 'TALLER')
      return UIColors.taller;
    else if (type == 'FERIA')
      return UIColors.feria;
    else
      return UIColors.merienda;
  }

  String getImage(){
    return 'assets/tec_edificio_a4.jpg';
  }

}
