import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:letsattend/router.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/view_models/settings_model.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:letsattend/widgets/modern_button.dart';

class AuthView extends StatefulWidget {
  @override
  AuthViewState createState() => AuthViewState();
}

class AuthViewState extends State<AuthView> {

  @override
  Widget build(BuildContext context) {

    final settings = Provider.of<SettingsModel>(context);

    final signInButton = ModernButton(
      'INICIAR SESIÓN',
      color: SharedColors.alizarin,
      onPressed: () => Navigator.of(context).pushNamed(Router.LOGIN_ROUTE),
    );

    final googleButton = ModernButton(
      'Ingresar con Google',
      color: Colors.white,
      textColor: SharedColors.google,
      onPressed: () => print('Google'),
      icon: FontAwesome.google,
    );

    final signUpText = Text(
      '¿No tienes una cuenta?',
      style: TextStyle(color: Colors.white38),
    );

    final signUpButton = MaterialButton(
      child: signUpText,
      onPressed: () => Navigator.of(context).pushNamed(Router.SIGN_UP_ROUTE),
    );

    final logo = Hero(
      tag: 'app-logo',
      child: FlutterLogo(
        size: 132,
        colors: Colors.deepOrange,
      ),
    );

    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        logo,
        SizedBox(height: 32),
        signInButton,
        SizedBox(height: 16),
        googleButton,
        signUpButton,
      ],
    );

    final paddedContent = Padding(
      padding: EdgeInsets.all(48),
      child: content,
    );

    final wave = TextLiquidFill(
      key: Key('liquid-auth'),
      text: '',
      waveColor: SharedColors.alizarin,
      boxBackgroundColor: Colors.transparent,
      boxHeight: 48.0,
    );

    final container = Container(
      child: Column(
        children: [
          Flexible(child: paddedContent),
          wave,
        ],
      ),
    );

    final appBar = AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: settings.nightMode ? Colors.white : Colors.black,
      ),
    );

    return Scaffold(
      body: SafeArea(child: container),
      drawer: DrawerView(Router.AUTH_ROUTE),
      appBar: appBar,
    );

  }

}
