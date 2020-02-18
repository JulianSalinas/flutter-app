import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/router.dart';
import 'package:letsattend/view_models/auth/auth_model.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/view_models/auth/auth_state.dart';
import 'package:letsattend/views/auth/auth_form.dart';
import 'package:letsattend/widgets/modern_button.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {

  signIn(String email, String password) async {

    final auth = Provider.of<AuthModel>(context);

    /// If for some unusual reason (or test) user is already logged
    /// but is still in the sign in page, we should sign out
    if(auth.status == AuthStatus.LOGGED_IN) {
      await auth.signOut();
    }

    auth.signIn(email, password).then(signInSuccess, onError: signInError);
  }

  signInSuccess(User user){
    print('Logged as: $user');
    Navigator.pushReplacementNamed(context, Router.HOME_ROUTE);
  }

  signInError(Object error) {
    if (error.runtimeType == PlatformException) {
      PlatformException exception = error;
      switch(exception.code){
        case 'ERROR_WRONG_PASSWORD':
          return print('Contraseña incorrecta');
        case 'ERROR_INVALID_EMAIL':
          return print('Correo no válido');
        case 'ERROR_USER_NOT_FOUND':
          return print('Usuario no encontrado');
      }
    }
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
                    onPressed: Navigator.of(context).pop)
              ]);
        });
  }

  retrieveFailure(Object error) {
    if (error.runtimeType == PlatformException) {
      PlatformException exception = error;
      if (exception.code == 'ERROR_INVALID_EMAIL') {
        print('Correo no válido');
      } else if (exception.code == 'ERROR_USER_NOT_FOUND') {
        print('Usuario no encontrado');
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final headline = TypewriterAnimatedTextKit(
      duration: Duration(seconds: 9),
      text: ['BIENVENIDO', 'INICIA SESIÓN', '...O REGISTRATE'],
      textStyle: Theme.of(context).textTheme.headline,
    );

    final authForm = AuthForm(
      confirmation: false,
      submitText: 'Ingresar',
      submit: signIn,
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

    final retrieveButton = CupertinoButton(
      child: retrieveText,
      onPressed: retrieveForgottenPassword,
    );

    final loginContent = [
      headline,
      SizedBox(height: 16),
      authForm,
      SizedBox(height: 16),
      Text('Ó puedes', textAlign: TextAlign.center),
      SizedBox(height: 16),
      googleButton,
      retrieveButton
    ];

    final wrapper = Column(
      children: loginContent,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );

    final container = Container(
      width: 280,
      child: wrapper,
    );

    return Scaffold(body: SafeArea(child: container));
  }
}
