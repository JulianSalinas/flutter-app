import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/locator.dart';
import 'package:letsattend/router/router.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/shared/status.dart';
import 'package:letsattend/blocs/auth_bloc.dart';
import 'package:letsattend/blocs/news_bloc.dart';
import 'package:letsattend/blocs/settings_bloc.dart';
import 'package:letsattend/views/home/home_view.dart';
import 'package:letsattend/views/auth/auth_view.dart';

///  main()
///  |- LetsAttendApp
///         |- MaterialLetsAttendApp
///                   |- LetsAttendEntry
///              ______________|______________
///             |             |             |
///         loadView      homeView      loginView

Future<void> main() async {

  // Fix for: Unhandled Exception:
  // ServicesBinding.defaultBinaryMessenger
  // was accessed before the binding was initialized.
  WidgetsFlutterBinding.ensureInitialized();

  /// To use human-readable dates
  Jiffy.locale('es');

  /// To load lazy modules
  setupLocator();

  /// Entry point of the Flutter application
  runApp(LetsAttendApp());
}

/// Global providers are specified here
/// [See] https://pub.dev/packages/provider
class LetsAttendApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final auth = ChangeNotifierProvider<AuthBloc>(
      create: (context) => locator<AuthBloc>(),
    );

    final settings = ChangeNotifierProvider<SettingsBloc>(
      create: (context) => locator<SettingsBloc>(),
    );

    return MultiProvider(
      providers: [auth, settings],
      child: MaterialLetsAttendApp(),
    );

  }
}

/// Settings and routing are configured here.
/// This allows theme to be change on-the-fly
class MaterialLetsAttendApp extends StatelessWidget {

  final router = CustomRouter();

  @override
  Widget build(BuildContext context) {

    final settings = Provider.of<SettingsBloc>(context);

    final theme = ThemeData(
      brightness: settings.brightness,
      primarySwatch: Colors.red,
      accentColor: settings.nightMode ? Colors.white : Colors.red,
      textSelectionTheme: TextSelectionThemeData(selectionHandleColor: SharedColors.alizarin),
    );

    return MaterialApp(
      theme: theme,
      title: 'Let\'s Attend',
      home: LetsAttendEntry(),
      onGenerateRoute: router.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );

  }
}

/// Opens the issue view according of the user authentication.
class LetsAttendEntry extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthBloc>(context);

    final loadView = Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );

    final homeView = ChangeNotifierProvider<NewsBloc>(
      create: (context) => locator<NewsBloc>(),
      child: HomeView(),
    );

    return auth.status == Status.Uninitialized
        ? loadView
        : auth.status == Status.Authenticated
        ? homeView
        : AuthView();
  }
}

