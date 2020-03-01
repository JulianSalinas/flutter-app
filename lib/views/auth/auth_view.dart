import 'package:letsattend/shared/codes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:letsattend/router/routes.dart';
import 'package:letsattend/models/auth.dart';
import 'package:letsattend/shared/colors.dart';

import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:letsattend/blocs/settings_bloc.dart';
import 'package:letsattend/blocs/auth_bloc.dart';
import 'package:letsattend/shared/status.dart';

import 'package:letsattend/widgets/custom/formal_text.dart';
import 'package:letsattend/widgets/custom/rounded_button.dart';
import 'package:letsattend/widgets/animation/liquid_bottom.dart';

class AuthView extends StatefulWidget {
  @override
  AuthViewState createState() => AuthViewState();
}

class AuthViewState extends State<AuthView> {
  void signIn() async {
    final auth = Provider.of<AuthBloc>(context, listen: false);
    final payload = await auth.signInWithGoogle();
    if (payload.hasError) _displayError(payload.errorCode);
  }

  void _displayError(String errorCode) {
    String message = errorCode == Codes.networkRequestFailed
        ? 'Revise la conexión a internet.'
        : 'No se ha podido iniciar sesión, intente con otra opción.';
    showDialog(context: context, child: buildAlert(context, message));
  }

  Widget buildAlert(BuildContext context, String message) {
    final textStyle = TextStyle(color: Colors.white);

    final closeButton = FlatButton(
      child: Text('ENTENDIDO'),
      color: Colors.white,
      onPressed: Navigator.of(context).pop,
    );

    return AlertDialog(
      backgroundColor: Colors.red,
      actions: [closeButton],
      title: Text('Atención', style: textStyle),
      content: Text(message, style: textStyle),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBloc>(context);
    final settings = Provider.of<SettingsBloc>(context);

    final signInButton = RoundedButton(
      'Iniciar Sesión',
      color: SharedColors.alizarin,
      onPressed: () => Navigator.of(context).pushNamed(Routes.loginRoute),
    );

    final googleButton = RoundedButton(
      'Ingresar con Google',
      color: Colors.white,
      icon: FontAwesome.google,
      textColor: SharedColors.google,
      onPressed: signIn,
    );

    final signUpText = Text(
      '¿No tienes una cuenta?',
      style: TextStyle(color: Colors.grey.withOpacity(0.6)),
    );

    final signUpButton = MaterialButton(
      child: signUpText,
      onPressed: () => Navigator.of(context).pushNamed(Routes.signUpRoute),
    );

    final logo = Hero(
      tag: 'app-logo',
      child: FlutterLogo(size: 132, colors: Colors.deepOrange),
    );

    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        logo,
        SizedBox(height: 32),
        if (auth.status != Status.Authenticating) ...[
          signInButton,
          SizedBox(height: 16),
          googleButton,
          signUpButton,
        ] else ...[
          SizedBox(height: 16),
          Center(child: CircularProgressIndicator()),
        ],
        SizedBox(height: 48),
      ],
    );

    final scrollableContent = Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(48),
        child: content,
      ),
    );

    final wave = Hero(
      tag: 'liquid-animation',
      child: LiquidBottom(
        boxHeight: 48,
        waveColor: SharedColors.alizarin,
        boxBackgroundColor: Colors.transparent,
      ),
    );

    final container = Container(
      constraints: BoxConstraints.expand(),
      child: Stack(
        children: [
          scrollableContent,
          Positioned(
            bottom: 0,
            child: wave,
          ),
        ],
      ),
    );

    final appBar = AppBar(
      elevation: 0,
      title: FormalText(
        'Bienvenido',
        color: settings.nightMode ? Colors.white : Colors.black,
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: settings.nightMode ? Colors.white : Colors.black,
      ),
    );

    return Scaffold(
      body: SafeArea(child: container),
      drawer: DrawerView(Routes.authRoute),
      appBar: appBar,
    );
  }
}
