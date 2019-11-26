import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:letsattend/shared/uinput.dart';
import 'package:letsattend/shared/jbutton.dart';
import 'package:letsattend/colors/flat_ui.dart';
import 'package:letsattend/screens/signUp.dart';
import 'package:letsattend/colors/ui_colors.dart';
import 'package:letsattend/providers/palette.dart';
import 'package:letsattend/theme/theme_screen.dart';


class Login extends StatefulWidget {
    @override
    LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();

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
                icon: Icon(MaterialCommunityIcons.mail_ru),
                controller: emailCtrl,
            )
        );

        final passwordField = Hero(
            tag: 'password-field',
            child: UInput(
                hintText: 'Contraseña',
                obscureText: true,
                icon: Icon(MaterialCommunityIcons.key),
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
            onPressed: () => print('Ingresar')
        );

        final signUpButton = JButton(
            'REGISTRAR',
            color: FlatUI.wetAsphalt,
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUp())
            )
        );

        final authContent = [
            Expanded(flex: 0, child: loginButton),
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
                onPressed: () => print('Retrieve password')
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
            constraints: BoxConstraints(minWidth: 280)
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