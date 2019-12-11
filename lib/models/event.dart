import 'package:flutter/cupertino.dart';
import 'package:letsattend/colors/ui_colors.dart';
import 'package:letsattend/models/person.dart';

class Event {

  String title;
  String type;
  String location;
  String code;
  String description;
  DateTime end;
  DateTime start;
  List<Person> people;

  Event({
    this.title,
    this.type,
    this.location,
    this.code,
    this.end,
    this.start,
    this.people,
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

}
