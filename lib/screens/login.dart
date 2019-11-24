import 'package:flutter/material.dart';

class Login extends StatefulWidget {
    @override
    LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    @override
    Widget build(BuildContext context) {

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

        final loginButon = Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Color(0xff01A0C7),
            child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {},
                child: Text("Login",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
            ),
        );

        final content = [
            emailField,
            passwordField,
            loginButon
        ];

        return SafeArea(
            child: Column(
                children: content,
                mainAxisAlignment: MainAxisAlignment.center
            )
        );

    }

}