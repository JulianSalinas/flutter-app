import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/widgets/modern_input.dart';
import 'package:letsattend/widgets/modern_button.dart';
import 'package:letsattend/services/auth/auth_code.dart';
import 'package:letsattend/view_models/auth/auth_model.dart';

class SignIn extends StatefulWidget {
  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {

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
    auth.signIn(email, password).catchError(signInError);
  }

  signInError(Object error) {

    if(error.runtimeType != PlatformException) {
      print('Unexpected error while Sign In');
      return;
    }

    PlatformException exception = error;
    if(exception.code == AuthCode.ERROR_WRONG_PASSWORD)
      passwordError = 'Contraseña incorrecta';
    else if (exception.code == AuthCode.ERROR_INVALID_EMAIL)
      emailError = 'El correo no existe';
    else if (exception.code == AuthCode.ERROR_USER_NOT_FOUND)
      emailError = 'El usuario no existe';
  }

  /// TODO: Change method for one real
  retrieveForgottenPassword() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Recuperar contraseña'),
            content: Text('¿Desea enviar la contraseña a su correo?'),
            actions: <Widget>[
              new FlatButton(
                  child: new Text('CANCELAR'),
                  onPressed: Navigator.of(context).pop),
              new FlatButton(
                  child: new Text('ENVIAR'), onPressed: sendPasswordResetEmail)
            ],
          );
        });
  }

  sendPasswordResetEmail() {
//    Navigator.of(context).pop();
//    auth
//        .sendPasswordResetEmail(email: emailCtrl.text)
//        .then(retrieveSuccess, onError: retrieveFailure);
  }

  retrieveSuccess(Object result) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Recuperar contraseña'),
              content: Text('Tu contraseña se ha enviado a tu correo'),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('ENTENDIDO'),
                  onPressed: Navigator.of(context).pop,
                )
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {

    final headline = TypewriterAnimatedTextKit(
      speed: Duration(milliseconds: 200),
      text: ['BIENVENIDO', 'INICIA SESIÓN', '...O REGISTRATE'],
      textStyle: Theme.of(context).textTheme.headline,
    );

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
      color: SharedColors.midnightBlue,
      onPressed: signIn,
    );

    final googleButton = ModernButton(
      'Ingresar con Google',
      color: SharedColors.google,
      onPressed: () => print('Google'),
      icon: FontAwesome.google,
    );

    final retrieveText = Text(
      '¿Has olvidado tu contraseña?',
      style: TextStyle(color: SharedColors.peterRiver),
    );

    final retrieveButton = MaterialButton(
      child: retrieveText,
      onPressed: retrieveForgottenPassword,
    );

    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        headline,
        SizedBox(height: 16),
        emailField,
        SizedBox(height: 16),
        passwordField,
        SizedBox(height: 16),
        submitButton,
        SizedBox(height: 16),
        Text('Ó puedes', textAlign: TextAlign.center),
        SizedBox(height: 16),
        googleButton,
        retrieveButton
      ],
    );

    final container = Container(
      padding: EdgeInsets.all(48),
      child: content,
    );

    return Scaffold(body: SafeArea(child: container));
  }
}
