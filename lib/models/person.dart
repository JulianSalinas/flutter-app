import 'package:flutter/material.dart';
import 'package:letsattend/shared/utils.dart';
import 'package:letsattend/shared/colors.dart';

class Person {

  final String name;

  Person(this.name);

  Color get color {
    return getColorFor(name, SharedColors.flat);
  }

  String get initial {
    return initials[0];
  }

  String get initials {
    return getInitialsFrom(name);
  }

}
