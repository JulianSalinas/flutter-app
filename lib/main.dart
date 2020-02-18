import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/app.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/view_models/auth/auth_model.dart';
import 'package:letsattend/view_models/settings_model.dart';

void main() {

  /// To use human-readable dates
  Jiffy.locale('es');

  /// To load lazy modules
  setupLocator();

  /// Entry point of the Flutter application
  runApp(LetAttendApp());

}

class LetAttendApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    /// [See] https://pub.dev/packages/provider
    final providers = [
      ChangeNotifierProvider<AuthModel>(
        create: (context) => locator<AuthModel>(),
      ),
      ChangeNotifierProvider<SettingsModel>(
        create: (context) => locator<SettingsModel>(),
      ),
    ];

    /// Renders the applications with the theme data
    return MultiProvider(
      providers: providers,
      child: Material(child: ThemedApp()),
    );

  }

}