import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:letsattend/colors/flat_ui.dart';
import 'package:letsattend/colors/ui_colors.dart';
import 'package:letsattend/providers/auth.dart';
import 'package:letsattend/providers/scheme.dart';
import 'package:letsattend/screens/auth/sign_up.dart';
import 'package:letsattend/screens/auth/auth_form.dart';
import 'package:letsattend/shared/unique_button.dart';
import 'package:letsattend/shared/custom_input.dart';
import 'package:letsattend/screen.dart';
import 'package:provider/provider.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  submit(Auth auth) => (String email, String password) {
    print('email: $email, password: $password');
//    auth.signInWithEmailAndPassword(email, password);
  };

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

  loginSuccess(AuthResult result) {
    FirebaseUser user = result.user;
    print(user);
  }

  loginFailure(Object error) {
    if (error.runtimeType == PlatformException) {
      PlatformException exception = error;

      if (exception.code == 'ERROR_WRONG_PASSWORD') {
        print('Contraseña incorrecta');
      } else if (exception.code == 'ERROR_INVALID_EMAIL') {
        print('Correo no válido');
      } else if (exception.code == 'ERROR_USER_NOT_FOUND') {
        print('Usuario no encontrado');
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<Auth>(context);
    final scheme = Provider.of<Scheme>(context);

    final headline = TypewriterAnimatedTextKit(
      duration: Duration(seconds: 9),
      text: ['BIENVENIDO', 'INICIA SESIÓN', '...O REGISTRATE'],
      textStyle: Theme.of(context).textTheme.headline,
    );

    final authForm = AuthForm(
      confirmation: false,
      submitText: 'Ingresar',
      submit: submit(auth),
    );

    final googleButton = UniqueButton(
      'Ingresar con Google',
      color: UIColors.google,
      onPressed: () => print('Google'),
      icon: FontAwesome.google,
    );

    final retrieveText = Text(
      '¿Has olvidado tu contraseña?',
      style: TextStyle(color: FlatUI.peterRiver),
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

    return Scaffold(body: SafeArea(child: Screen(child: container)));
  }
}
