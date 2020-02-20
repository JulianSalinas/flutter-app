import 'package:letsattend/router.dart';
import 'package:letsattend/view_models/settings_model.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:letsattend/widgets/modern_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/widgets/modern_input.dart';
import 'package:letsattend/widgets/modern_button.dart';
import 'package:letsattend/models/payload.dart';
import 'package:letsattend/view_models/auth/auth_model.dart';

class SignInView extends StatefulWidget {
  @override
  SignInViewState createState() => SignInViewState();
}

class SignInViewState extends State<SignInView> {

  String emailError;
  String passwordError;
  String confirmationError;

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmationCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailCtrl.text = 'july12sali@gmail.com';
    passwordCtrl.text = 'telacreistewe';
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmationCtrl.dispose();
    super.dispose();
  }

  void signIn() async {

    final auth = Provider.of<AuthModel>(context, listen: false);
    String email = emailCtrl.text.trim();
    String password = passwordCtrl.text.trim();
    final payload = await auth.signIn(email, password);

    if(payload.hasError) {
      if(payload.errorCode == AuthPayload.ERROR_WRONG_PASSWORD)
        setState(() => passwordError = 'Contraseña incorrecta');
      else if (payload.errorCode == AuthPayload.ERROR_INVALID_EMAIL)
        setState(() => emailError = 'El correo es inválido');
      else if (payload.errorCode == AuthPayload.ERROR_USER_NOT_FOUND)
        setState(() => emailError = 'El usuario no ha sido registrado');
    }
    else {
      Navigator.of(context).pop();
    }

  }

  @override
  Widget build(BuildContext context) {

    final settings = Provider.of<SettingsModel>(context);

    final emailField = ModernInput(
      hintText: 'Email',
      errorText: emailError,
      controller: emailCtrl,
      keyboardType: TextInputType.text,
      leading: Icon(MaterialCommunityIcons.at),
    );

    final passwordField = ModernInput(
      obscureText: true,
      hintText: 'Contraseña',
      errorText: passwordError,
      controller: passwordCtrl,
      keyboardType: TextInputType.text,
      leading: Icon(MaterialCommunityIcons.key),
    );

    final submitButton = ModernButton(
      'INGRESAR',
      color: SharedColors.alizarin,
      onPressed: signIn,
    );

    final googleButton = ModernButton(
      'Ingresar con Google',
      color: Colors.white,
      textColor: SharedColors.google,
      onPressed: () => print('Google'),
      icon: FontAwesome.google,
    );

    final auxText = Text(
      '¿Has olvidado tu contraseña?',
      style: TextStyle(color: Colors.white38),
    );

    final auxButton = MaterialButton(
      child: auxText,
      onPressed: () {
        Navigator.of(context).pushNamed(Router.PASSWORD_RESET_ROUTE);
      },
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
        emailField,
        SizedBox(height: 16),
        passwordField,
        SizedBox(height: 16),
        submitButton,
        SizedBox(height: 16),
        Text('Ó puedes', textAlign: TextAlign.center),
        SizedBox(height: 16),
        googleButton,
        auxButton
      ],
    );

    final paddedContent = Padding(
      padding: EdgeInsets.all(48),
      child: content,
    );

    final wave = TextLiquidFill(
      key: Key('liquid-sign-in'),
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
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: Navigator.of(context).pop,
      ),
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: settings.nightMode ? Colors.white : Colors.black,
      ),
    );

    return Scaffold(
      body: SafeArea(child: container),
      drawer: DrawerView(Router.LOGIN_ROUTE),
      appBar: appBar,
    );

  }

}
