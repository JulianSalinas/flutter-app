import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:letsattend/colors/flat_ui.dart';
import 'package:letsattend/colors/ui_colors.dart';
import 'package:letsattend/providers/palette.dart';
import 'package:letsattend/shared/jbutton.dart';
import 'package:letsattend/theme/theme_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class Login extends StatefulWidget {
    @override
    LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

    static final InputBorder inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(32.0)
    );

    static final InputDecoration inputDecoration = InputDecoration(
        border: inputBorder,
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0)
    );

    @override
    Widget build(BuildContext context) {

        final Palette palette = Provider.of<Palette>(context);

        final welcomeLabel = Text(
            'INICIO DE SESIÓN',
            style: Theme.of(context).textTheme.headline,
        );

        final emailField = TextField(
            obscureText: false,
            decoration: inputDecoration.copyWith(hintText: 'Email')
        );

        final passwordField = TextField(
            obscureText: true,
            decoration: inputDecoration.copyWith(hintText: 'Contraseña')
        );

        final loginButton = JButton(
            'INGRESAR',
            color: FlatUI.midnightBlue,
            onPressed: () => print('Ingresar')
        );

        final signUpButton = JButton(
            'REGISTRAR',
            color: FlatUI.wetAsphalt,
            onPressed: () => print('Registrar')
        );

        final authContent = [
            Expanded(flex: 1, child: loginButton),
            SizedBox(width: 8),
            Expanded(flex: 1, child: signUpButton),
        ];

        final authButtons = Row(
            children: authContent,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
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

        final loginContent = [
            welcomeLabel,
            SizedBox(height: 16),
            emailField,
            SizedBox(height: 16),
            passwordField,
            SizedBox(height: 16),
            authButtons,
            SizedBox(height: 16),
            Text('Ó puedes', textAlign: TextAlign.center),
            SizedBox(height: 16),
            googleButton
        ];
        
        final loginColumn = Column(
            children: loginContent,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
        );

        // IntrinsicWidth adjusts the column to its widest child
        final loginContainer = IntrinsicWidth(
            child: loginColumn,
        );

        return Material(
            child: SafeArea(
                child: ThemeScreen(
                    child: loginContainer
                )
            )
        );

    }

}