import 'package:flutter/material.dart';

/// Text used for toolbars and buttons in this app
class FormalText extends StatelessWidget {

  final String text;
  final Color color;

  final double fontSize;

  FormalText(this.text, {
    this.color,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {

    /// Gives a formal-like style
    final textStyle = TextStyle(
      fontSize: fontSize,
      letterSpacing: 2.4,
      fontWeight: FontWeight.w300,
      color: color ?? Colors.white,
    );

    /// Material wrappers solves a bug when it is inside Hero widget
    return Material(
      color: Colors.transparent,
      child: Text(text.toUpperCase(), style: textStyle),
    );

  }

}
