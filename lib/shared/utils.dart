import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';

class SharedUtils {

  /// Regex to recognize Urls
  static final RegExp exp = new RegExp(
      r"[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)");

  /// Returns the first two initials from a name or
  /// just the first one if it is just the stack name
  /// Ej. 'Julian Salinas Rojas' -> JS
  static String getInitialsFrom(String? text) {
    if (text == null || text.length == 0) return '#';

    RegExp exp = RegExp(r'\b\w');
    Iterable<RegExpMatch> matches = exp.allMatches(text);

    if (matches.length == 0) return '#';

    String? first = matches.elementAt(0).group(0);

    if (matches.length == 1)
      return first != null ? first.toUpperCase() : "#";

    String? second = matches.elementAt(1).group(0);

    return second != null ? '$first$second'.toUpperCase() : first!.toUpperCase();
  }

  /// Returns always the same color for a given key and set of ui.colors
  /// Ej. 'Julian Salinas' always is blue
  static Color getColorFor(String? text, Iterable<Color> colors) {
    if (text == null) return Colors.black;
    int value = text.hashCode.abs();
    int remainder = value % colors.length;
    return colors.length > 0 ? colors.elementAt(remainder) : Colors.black;
  }

  /// Returns true if the filter is contained
  /// Ej. chu is contained in 'Pikachuuu!'
  static bool containsFilter(String? filter, String content) {
    if (filter == null || filter.isEmpty) return false;

    RegExp regex = new RegExp(r'(\w+)', caseSensitive: false);

    String normFilter = removeDiacritics(filter.toLowerCase());
    String normContent = removeDiacritics(content.toLowerCase());

    var words = regex.allMatches(normFilter).map((word) => word.group(0));
    return words.any((word) => word != null && normContent.contains(word));
  }

  /// Returns a match in a given text
  static RegExpMatch? findUrl(String? text) {
    if(text == null) return null;
    Iterable<RegExpMatch> matches = exp.allMatches(text);
    return matches.length == 0 ? null : matches.first;
  }

  /// Removes unnecessary white spaces
  static String? cleanText(Object? text) {
    if(text == null) return null;
    var trimmed = text.toString().trim();
    return trimmed.replaceAll(new RegExp(r'\s{2,}'), ' ');
  }

  static String? capitalize(String? text) {
    if (text == null) return null;
    if (text.length < 2) return text.toUpperCase();
    final lowerCaseText = text.toLowerCase();
    return '${lowerCaseText[0].toUpperCase()}${lowerCaseText.substring(1)}';
  }

  static String? formatName(String? name) {
    if(name == null) return null; 
    final splittedName = cleanText(name)!.split(" ");
    final formattedNames = splittedName.map(capitalize);
    return formattedNames.join(" ");
  }

  static DateTime castMilliseconds(int milliseconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

}
