import 'package:flutter/cupertino.dart';
import 'package:letsattend/colors/flat_ui.dart';
import 'package:letsattend/scripts/utils.dart';

class Person {

  String about;
  String country;
  String name;

  Person({
    this.about,
    this.country,
    @required this.name
  });

  Person.empty();

  Color getColor(){
    return getColorFor(name, FlatUI.values);
  }

  String getInitial(){
    return getInitials()[0];
  }

  String getInitials(){
    return getInitialsFrom(name);
  }

}