import 'package:flutter/material.dart';

/// Text used for fix hero animations
class HeroText extends Text {

  final String tag;
  final String text;

  final TextStyle style;
  final int maxLines;
  final TextOverflow overflow;

  HeroText(this.text, {
    this.tag,
    this.style,
    this.maxLines,
    this.overflow
  }) : super(text);

  @override
  Widget build(BuildContext context) {

    final textStyle = TextStyle(
      fontSize: 14,
    );

    final content = Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        style: textStyle.merge(style),
    );

    /// Material wrappers solves a bug when it is inside Hero widget
    final container = Material(
      color: Colors.transparent,
      child: content
    );

    return Hero(
      tag: tag,
      child: container,
    );

  }


}
