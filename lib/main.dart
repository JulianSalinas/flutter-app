import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import 'package:letsattend/controllers/speakers_controller.dart';
import 'package:letsattend/locator.dart';

import 'package:letsattend/views/speakers/speaker_view.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/controllers/auth_controller.dart';
import 'package:letsattend/controllers/theme_controller.dart';

import 'services/auth_service.dart';

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
      ChangeNotifierProvider<AuthController>(
        create: (context) => locator<AuthController>(),
      ),
      ChangeNotifierProvider<ThemeController>(
        create: (context) => locator<ThemeController>(),
      ),
      ChangeNotifierProvider<SpeakersController>(
        create: (context) => locator<SpeakersController>(),
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

    // TODO Get current theme

    final routes = {
      '/': (context) => SpeakerList(),
    };

    return MaterialApp(
      title: 'Let\'s Attend',
      routes: routes,
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      debugShowCheckedModeBanner: false,
    );

  }
}

