import 'package:flutter/material.dart';


class ThemeText extends StatelessWidget {

    final String text;

    ThemeText(this.text);

    @override
    Widget build(BuildContext context) {

        final style = TextStyle(
            letterSpacing: 2.4,
            fontWeight: FontWeight.w300
        );

        return Text(text, style: style);
    }

}