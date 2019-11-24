import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/providers/palette.dart';
import 'package:letsattend/theme/theme_screen.dart';


class ThemeApp extends StatelessWidget {

    final Widget startWidget;

    ThemeApp(this.startWidget);

    @override
    Widget build(BuildContext context) {

        final Palette palette = Provider.of<Palette>(context);

        ThemeData themeData = ThemeData(
            brightness: palette.darkMode ? Brightness.dark : Brightness.light,
            primarySwatch: Colors.purple,
        );

        return MaterialApp(
            home: Scaffold(
                body: ThemeScreen(startWidget)
            ),
            theme: themeData
        );

    }

}