import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:letsattend/views/speakers/speakers_view.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/locator.dart';
import 'package:letsattend/view_models/auth_model.dart';
import 'package:letsattend/view_models/theme_model.dart';
import 'package:letsattend/view_models/speakers_model.dart';

void main() {

  /// To use human-readable dates
  Jiffy.locale('es');

  /// To load lazy modules
  setupLocator();

  /// Entry point of the Flutter application
  runApp(App());

}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    /// [See] https://pub.dev/packages/provider
    final providers = [
      ChangeNotifierProvider<AuthModel>(
        create: (context) => locator<AuthModel>(),
      ),
      ChangeNotifierProvider<ThemeModel>(
        create: (context) => locator<ThemeModel>(),
      ),
      ChangeNotifierProvider<SpeakersModel>(
        create: (context) => locator<SpeakersModel>(),
      )
    ];

    /// Renders the applications with the theme data
    return MultiProvider(
      providers: providers,
      child: Material(child: ThemedApp()),
    );

  }

}

class ThemedApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ThemeModel themeModel = Provider.of<ThemeModel>(context);

    final routes = {
      '/': (context) => SpeakersView(),
    };

    final themeData = ThemeData(
      brightness: themeModel.brightness,
      primarySwatch: Colors.red,
    );

    return MaterialApp(
      title: 'Let\'s Attend',
      routes: routes,
      theme: themeData,
      debugShowCheckedModeBanner: false,
    );

  }
}

