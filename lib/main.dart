import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/router.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/view_models/auth_model.dart';
import 'package:letsattend/view_models/theme_model.dart';
import 'package:letsattend/view_models/navigation_model.dart';

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
      ChangeNotifierProvider<NavigationModel>(
        create: (context) => locator<NavigationModel>(),
      ),
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

    final theme = ThemeData(
      brightness: themeModel.brightness,
      primarySwatch: Colors.red,
    );

    return MaterialApp(
      title: 'Let\'s Attend',
      theme: theme,
      initialRoute: HomeRoute,
      onGenerateRoute: generateRoute,
      navigatorKey: locator<NavigationModel>().navigatorKey,
      debugShowCheckedModeBanner: false,
    );

  }
}

