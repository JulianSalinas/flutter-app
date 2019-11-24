import 'package:flutter/material.dart';


class ThemeText extends StatelessWidget {

    final String text;
    final Color color;

    ThemeText(this.text, { this.color });

    @override
    Widget build(BuildContext context) {

        final style = TextStyle(
            color: color,
            letterSpacing: 2.4,
            fontWeight: FontWeight.w300
        );

        return Text(text, style: style);
    }

}