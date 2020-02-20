import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/views/home/home.dart';
import 'package:letsattend/views/auth/auth_view.dart';
import 'package:letsattend/view_models/auth/auth_model.dart';
import 'package:letsattend/view_models/auth/auth_status.dart';


class ThemedApp extends StatefulWidget {

  @override
  _ThemedAppState createState() => _ThemedAppState();
}

class _ThemedAppState extends State<ThemedApp> {

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthModel>(context);

    final loadingScreen = Scaffold(
      body: Center(child: CircularProgressIndicator())
    );

    switch (auth.status) {
      case AuthStatus.Uninitialized:
        return loadingScreen;
      case AuthStatus.Authenticated:
        return Home();
      default:
        return AuthView();
    }

  }

}
