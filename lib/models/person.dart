import 'package:flutter/material.dart';
import 'package:letsattend/shared/utils.dart';
import 'package:letsattend/shared/colors.dart';

class Person {

  final String name;

  Person(this.name);

  Color get color {
    return SharedUtils.getColorFor(name, SharedColors.flat);
  }

  String get initial {
    return name.length >= 1 ? initials[0] : '#';
  }

  String get initials {
    return SharedUtils.getInitialsFrom(name);
  }

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Person && name == other.name;
  }

  @override
  String toString() {
    return 'Person{ name: $name }';
  }

}
