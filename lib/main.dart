import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/screens/auth/login.dart';
import 'package:letsattend/providers/palette.dart';


void main() => runApp(Main());

class Main extends StatelessWidget {

    @override
    Widget build(BuildContext context) {

        return MultiProvider(
            providers: [
                ChangeNotifierProvider<Palette>(builder: (context) => Palette())
            ],
            child: MainApp()
        );

    }

}

class MainApp extends StatelessWidget {

    @override
    Widget build(BuildContext context) {

        final Palette palette = Provider.of<Palette>(context);

        ThemeData themeData = ThemeData(
            brightness: palette.darkMode ? Brightness.dark : Brightness.light,
            primarySwatch: Colors.blue,
        );

        return Material(
            child: MaterialApp(home: Login(), theme: themeData)
        );

    }

}