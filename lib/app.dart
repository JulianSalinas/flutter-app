import 'package:flutter/material.dart';
import 'package:letsattend/views/auth/sign_in.dart';
import 'package:letsattend/views/home/home.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/router.dart';
import 'package:letsattend/view_models/auth/auth_state.dart';
import 'package:letsattend/view_models/auth/auth_model.dart';
import 'package:letsattend/view_models/settings_model.dart';


class ThemedApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthModel>(context);

    final router = Router(auth);

    final theme = ThemeData(
      brightness: Provider.of<SettingsModel>(context).brightness,
      primarySwatch: Colors.red,
    );

    final builder = (_, widget) => StreamBuilder(
      stream: auth.onAuthChanged,
      builder: buildEntryPoint,
    );

    return MaterialApp(
      title: 'Let\'s Attend',
      theme: theme,
      builder: builder,
      onGenerateRoute: router.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );

  }

  Widget buildEntryPoint(BuildContext context, AsyncSnapshot snapshot) {

    final auth = Provider.of<AuthModel>(context);

    /// App is loading user information
    if (snapshot.connectionState == ConnectionState.waiting) {
      print('Waiting for connection');
      auth.status = AuthStatus.NOT_DETERMINED;
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    /// User is already logged
    else if (snapshot.hasData) {
      print('User already logged');
      auth.status = AuthStatus.LOGGED_IN;
      return Home();
    }

    /// User is not logged
    else if (!snapshot.hasError) {
      assert(!snapshot.hasData);
      print('You are not logged');
      auth.status = AuthStatus.NOT_LOGGED_IN;
      return SignIn();
    }

    assert(snapshot.hasError);
    String error = snapshot.error.toString();
    print('Something went wrong while logging: $error');
    auth.status = AuthStatus.NOT_LOGGED_IN;
    return SignIn();

  }

}
