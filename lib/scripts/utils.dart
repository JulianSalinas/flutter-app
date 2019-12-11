import 'package:flutter/material.dart';

/// Returns the first two initials from a name or
/// just the first one if it is just the stack name
/// Ej. 'Julian Salinas Rojas' -> JS
String getInitialsFrom(String text) {
  if (text == null || text.length == 0) return '#';

  RegExp exp = RegExp(r'\b\w');
  Iterable<RegExpMatch> matches = exp.allMatches(text);

  if (matches.length == 0) return '#';

  String first = matches.elementAt(0).group(0);

  if (matches.length == 1) return first.toUpperCase();

  String second = matches.elementAt(1).group(0);
  return '$first$second'.toUpperCase();
}

/// Returns always the same color for a given key and set of colors
/// Ej. 'Julian Salinas' always is blue
Color getColorFor(String text, Iterable<Color> colors) {
  int value = text.hashCode.abs();
  int remainder = value % colors.length;
  return colors.length > 0 ? colors.elementAt(remainder) : Colors.black;
}
