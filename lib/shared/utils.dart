import 'package:diacritic/diacritic.dart';
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

/// Returns always the same color for a given key and set of ui.colors
/// Ej. 'Julian Salinas' always is blue
Color getColorFor(String text, Iterable<Color> colors) {
  int value = text.hashCode.abs();
  int remainder = value % colors.length;
  return colors.length > 0 ? colors.elementAt(remainder) : Colors.black;
}

bool containsFilter(String filter, String content){

  if(filter == null || filter.isEmpty)
    return false;

  RegExp regex = new RegExp(r'(\w+)', caseSensitive: false);

  String normFilter = removeDiacritics(filter.toLowerCase());
  String normContent = removeDiacritics(content.toLowerCase());

  var words = regex.allMatches(normFilter).map((word) => word.group(0));
  return words.any((word) => normContent.contains(word));

}