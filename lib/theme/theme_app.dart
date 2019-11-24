import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:letsattend/providers/palette.dart';


class ThemeApp extends StatelessWidget {

    final Widget child;

    ThemeApp(this.child);

    @override
    Widget build(BuildContext context) {

        final Palette palette = Provider.of<Palette>(context);

        ThemeData themeData = ThemeData(
            brightness: palette.darkMode ? Brightness.dark : Brightness.light,
            primarySwatch: Colors.red,
        );

        return MaterialApp(home: child, theme: themeData);

    }

}