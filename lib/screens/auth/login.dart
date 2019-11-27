import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:letsattend/colors/flat_ui.dart';
import 'package:letsattend/colors/ui_colors.dart';
import 'package:letsattend/providers/palette.dart';
import 'package:letsattend/screens/auth/signUp.dart';
import 'package:letsattend/shared/jbutton.dart';
import 'package:letsattend/shared/uinput.dart';
import 'package:letsattend/theme/theme_screen.dart';
import 'package:provider/provider.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
    @override
    LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final FirebaseAuth auth = FirebaseAuth.instance;

    String emailError;
    String passwordError;

    @override
    void initState(){
        super.initState();
        emailCtrl.text = 'july12sali@gmail.com';
        passwordCtrl.text = 'telacreistewe';
    }

    /// TODO: Change method for one real
    retrieveForgottenPassword(){
        showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text('Recuperar contraseña'),
                    content: Text('¿Desea enviar la contraseña a su correo?'),
                    actions: <Widget>[
                        new FlatButton(
                            child: new Text('CANCELAR'),
                            onPressed: Navigator.of(context).pop
                        ),
                        new FlatButton(
                            child: new Text('ENVIAR'),
                            onPressed: sendPasswordResetEmail
                        )
                    ],
                );
            }
        );
    }


    sendPasswordResetEmail(){
        Navigator.of(context).pop();
        auth.sendPasswordResetEmail(email: emailCtrl.text)
            .then(retrieveSuccess, onError: retrieveFailure);
    }

    retrieveSuccess(Object result){
        showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text('Recuperar contraseña'),
                    content: Text('Tu contraseña se ha enviado a tu correo'),
                    actions: <Widget>[
                        new FlatButton(
                            child: new Text('ENTENDIDO'),
                            onPressed: Navigator.of(context).pop
                        )
                    ]
                );
            }
        );
    }

    retrieveFailure(Object error){
        if (error.runtimeType == PlatformException){
            PlatformException exception = error;
            if (exception.code == 'ERROR_INVALID_EMAIL'){
                print('Correo no válido');
            }
            else if (exception.code == 'ERROR_USER_NOT_FOUND'){
                print('Usuario no encontrado');
            }
        }
    }

    loginWithEmailAndPassword() {
        auth.signInWithEmailAndPassword(
            email: emailCtrl.text,
            password: passwordCtrl.text,
        ).then(loginSuccess, onError: loginFailure);
    }

    loginSuccess(AuthResult result){
        FirebaseUser user = result.user;
        print(user);
    }

    loginFailure(Object error){

        if (error.runtimeType == PlatformException){
            PlatformException exception = error;

            if(exception.code == 'ERROR_WRONG_PASSWORD'){
                print('Contraseña incorrecta');
            }
            else if (exception.code == 'ERROR_INVALID_EMAIL'){
                print('Correo no válido');
                setState(() {
                    emailError = 'Correo no válido';
                });
            }
            else if (exception.code == 'ERROR_USER_NOT_FOUND'){
                print('Usuario no encontrado');
            }

        }

    }

    @override
    void dispose() {
        emailCtrl.dispose();
        passwordCtrl.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {

        final Palette palette = Provider.of<Palette>(context);

        final headlineText = Hero(
            tag: 'headline-text',
            child: TypewriterAnimatedTextKit(
                duration: Duration(seconds: 9),
                text: ['BIENVENIDO', 'INICIA SESIÓN', '...O REGISTRATE'],
                textStyle: Theme.of(context).textTheme.headline
            )
        );

        final emailField = Hero(
            tag: 'email-field',
            child: UInput(
                hintText: 'Email',
                obscureText: false,
                icon: Icon(MaterialCommunityIcons.mail_ru, color: FlatUI.peterRiver),
                controller: emailCtrl,
                errorText: emailError,
            )
        );

        final passwordField = Hero(
            tag: 'password-field',
            child: UInput(
                hintText: 'Contraseña',
                obscureText: true,
                icon: Icon(MaterialCommunityIcons.key, color: FlatUI.peterRiver),
                controller: passwordCtrl,
            )
        );

        final confirmationField = Hero(
            tag: 'confirmation-field',
            child: Visibility(
                visible: false,
                maintainSize: false,
                child: SizedBox.shrink()
            )
        );

        final loginButton = JButton(
            'INGRESAR',
            color: FlatUI.midnightBlue,
            onPressed: loginWithEmailAndPassword
        );

        final signUpButton = JButton(
            'REGISTRAR',
            color: FlatUI.wetAsphalt,
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUp())
            )
        );

        final authContent = [
            Expanded(flex: 1, child: loginButton),
            SizedBox(width: 8),
            Expanded(flex: 1, child: signUpButton),
        ];

        final authButtons = Row(
            children: authContent,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center
        );

        final createButton = Hero(
            tag: 'sign-up-button',
            child: Visibility(
                visible: false,
                maintainSize: false,
                child: SizedBox.shrink()
            )
        );

        final googleIcon = Icon(
            FontAwesome.google,
            color: palette.darkMode ? Colors.white : UIColors.google,
        );

        final googleButton = JButton(
            'INGRESAR CON GOOGLE',
            color: UIColors.google,
            onPressed: () => print('Google'),
            icon: googleIcon
        );

        final retrievePassword = Hero(
            tag: 'alternative-button',
            child: CupertinoButton(
                child: Text('¿Has olvidado tu contraseña?',
                    style: TextStyle(color: FlatUI.peterRiver)
                ),
                onPressed: retrieveForgottenPassword
            )
        );

        final loginContent = [
            headlineText,
            SizedBox(height: 16),
            emailField,
            SizedBox(height: 16),
            passwordField,
            confirmationField,
            SizedBox(height: 16),
            authButtons,
            createButton,
            SizedBox(height: 16),
            Text('Ó puedes', textAlign: TextAlign.center),
            SizedBox(height: 16),
            googleButton,
            retrievePassword
        ];

        final loginColumn = Column(
            children: loginContent,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
        );

        // IntrinsicWidth adjusts the column to its widest child
        final loginContainer = Container(
            child: IntrinsicWidth(child: loginColumn),
            constraints: BoxConstraints(minWidth: 280, maxWidth: 280)
        );

        return Scaffold(
            body: SafeArea(
                child: ThemeScreen(
                    child: loginContainer
                )
            )
        );

    }

}