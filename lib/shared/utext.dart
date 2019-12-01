import 'package:flutter/material.dart';

/// Text used for toolbars and buttons in this app
class UText extends StatelessWidget {

  final String text;
  final Color color;

  UText(this.text, {this.color});

  @override
  Widget build(BuildContext context) {

    /// Gives a formal-like style
    final textStyle = TextStyle(
      color: color,
      letterSpacing: 2.4,
      fontWeight: FontWeight.w300,
    );

    /// Material wrappers solves a bug when it is inside Hero widget
    return Material(
      color: Colors.transparent,
      child: Text(text.toUpperCase(), style: textStyle),
    );

  }
}
