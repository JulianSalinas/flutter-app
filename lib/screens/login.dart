import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:letsattend/colors/flat_ui.dart';
import 'package:letsattend/colors/ui_colors.dart';
import 'package:letsattend/providers/palette.dart';
import 'package:letsattend/shared/jbutton.dart';
import 'package:provider/provider.dart';


class Login extends StatefulWidget {
    @override
    LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    @override
    Widget build(BuildContext context) {

        final Palette palette = Provider.of<Palette>(context);

        final emailField = TextField(
            obscureText: false,
            style: style,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Email",
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        );

        final passwordField = TextField(
            obscureText: true,
            style: style,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Password",
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
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
            Icons.access_alarm,
            color: palette.darkMode ? Colors.white : UIColors.google,
        );

        final googleButton = JButton(
            'INGRESAR CON GOOGLE',
            color: UIColors.google,
            onPressed: () => print('Google'),
            icon: googleIcon
        );

        final loginContent = [
            emailField,
            SizedBox(height: 16),
            passwordField,
            SizedBox(height: 16),
            authButtons,
            SizedBox(height: 16),
            Text('Ó puedes'),
            SizedBox(height: 16),
            googleButton
        ];
        
        final loginColumn = Column(
            children: loginContent,
            mainAxisAlignment: MainAxisAlignment.center,
        );

        final loginContainer = Container(
            child: loginColumn,
            margin: EdgeInsets.all(48)
        );

        return SafeArea(child: loginContainer);

    }

}