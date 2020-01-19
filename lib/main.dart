import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:letsattend/core/services/database/database_service.dart';
import 'package:letsattend/core/services/database/firebase_service.dart';
import 'package:letsattend/locator.dart';

import 'package:letsattend/ui/views/home/home.dart';
import 'package:letsattend/ui/views/speakers/speaker_list.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/core/services/auth/auth_service.dart';
import 'package:letsattend/core/services/theme_service.dart';

import 'core/services/auth/firebase_auth_service.dart';

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
      ChangeNotifierProvider<AuthService>(
        create: (context) => locator<FirebaseAuthService>(),
      ),
      ChangeNotifierProvider<ThemeService>(
        create: (context) => locator<ThemeService>(),
      ),
      ChangeNotifierProvider<DatabaseService>(
        create: (context) => locator<FirebaseService>(),
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
      '/': (context) => People(),
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

