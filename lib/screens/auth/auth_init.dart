import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:letsattend/shared/custom_input.dart';
import 'package:letsattend/shared/unique_button.dart';
import 'package:letsattend/colors/flat_ui.dart';
import 'package:letsattend/screen.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthInit extends StatefulWidget {
  @override
  AuthInitState createState() => AuthInitState();
}

class AuthInitState extends State<AuthInit> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmationCtrl = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  signUpWithEmailAndPassword() {
    print('handleEmailAndPasswordSignUp');
    auth
        .createUserWithEmailAndPassword(
        email: emailCtrl.text, password: passwordCtrl.text)
        .then(signUpSuccess)
        .catchError(signUpFailure);
  }

  signUpSuccess(AuthResult result) {
    print(result);
  }

  signUpFailure(Object error) {
    if (error.runtimeType == PlatformException) {
      PlatformException exception = error;
      if (exception.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        print('El correo ya tiene una cuenta asociada');
      } else if (exception.code == 'ERROR_INVALID_EMAIL') {
        print('Correo no válido');
      }
    }
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final headlineText = Hero(
        tag: 'headline-text',
        child: TypewriterAnimatedTextKit(
            duration: Duration(seconds: 9),
            text: ['ES HORA DE', 'CREAR UNA CUENTA', '...O YA TIENES UNA?'],
            textStyle: Theme.of(context).textTheme.headline));

    final emailField = Hero(
        tag: 'email-field',
        child: CustomInput(
          hintText: 'Email',
          obscureText: false,
          icon: MaterialCommunityIcons.mail_ru,
          controller: emailCtrl,
        ));

    final passwordField = Hero(
        tag: 'password-field',
        child: CustomInput(
          hintText: 'Contraseña',
          obscureText: true,
          icon: MaterialCommunityIcons.key,
          controller: passwordCtrl,
        ));

    final confirmationField = Hero(
        tag: 'confirmation-field',
        child: CustomInput(
          obscureText: true,
          hintText: 'Confirmación',
          icon: MaterialCommunityIcons.chevron_right_circle_outline,
          controller: confirmationCtrl,
        ));

    final createButton = Hero(
        tag: 'sign-up-button',
        child: UniqueButton('CREAR E INGRESAR',
            color: FlatUI.midnightBlue, onPressed: signUpWithEmailAndPassword));

    final googleButton = Hero(
        tag: 'google-button',
        child: Visibility(
            visible: false, maintainSize: false, child: SizedBox.shrink()));

    final backButton = Hero(
        tag: 'alternative-button',
        child: CupertinoButton(
            child: Text('¿Ya tienes una cuenta?',
                style: TextStyle(color: FlatUI.peterRiver)),
            onPressed: () => Navigator.pop(context)));

    final loginContent = [
      headlineText,
      SizedBox(height: 16),
      emailField,
      SizedBox(height: 16),
      passwordField,
      SizedBox(height: 16),
      confirmationField,
      SizedBox(height: 16),
      createButton,
      googleButton,
      backButton
    ];

    final loginColumn = Column(
      children: loginContent,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );

    // IntrinsicWidth adjusts the column to its widest child
    final loginContainer = Container(
        child: IntrinsicWidth(child: loginColumn),
        constraints: BoxConstraints(minWidth: 280, maxWidth: 280));

    return Scaffold(body: SafeArea(child: Screen(child: loginContainer)));
  }
}
