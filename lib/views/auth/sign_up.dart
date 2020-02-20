import 'package:letsattend/router.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
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

class SignUpView extends StatefulWidget {
  @override
  SignUpViewState createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView> {

  String emailError;
  String passwordError;
  String confirmationError;

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmationCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmationCtrl.dispose();
    super.dispose();
  }

  void signUp() async {

    if (passwordCtrl.text.trim() == confirmationCtrl.text.trim()){
      setState(() => confirmationError = 'Este campo debe coincidir con la contraseña');
      return;
    }

    final auth = Provider.of<AuthModel>(context, listen: false);
    String email = emailCtrl.text.trim();
    String password = passwordCtrl.text.trim();
    final payload = await auth.signIn(email, password);

    if(payload.hasError) {
      if(payload.errorCode == AuthPayload.ERROR_EMAIL_ALREADY_IN_USE)
        setState(() => passwordError = 'El usuario ya está registrado');
      else if (payload.errorCode == AuthPayload.ERROR_INVALID_EMAIL)
        setState(() => emailError = 'El correo es inválido');
    }

  }

  @override
  Widget build(BuildContext context) {

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

    final confirmationField = ModernInput(
      obscureText: true,
      hintText: 'Confirmar contraseña',
      errorText: confirmationError,
      controller: confirmationCtrl,
      keyboardType: TextInputType.text,
      leading: Icon(AntDesign.lock),
    );

    final submitButton = ModernButton(
      'REGISTRARSE',
      color: SharedColors.alizarin,
      onPressed: signUp,
    );

    final auxText = Text(
      'Ya tengo una cuenta',
      style: TextStyle(color: Colors.white38),
    );

    final auxButton = MaterialButton(
      child: auxText,
      onPressed: Navigator.of(context).pop,
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
        confirmationField,
        SizedBox(height: 16),
        submitButton,
        auxButton
      ],
    );

    final paddedContent = Padding(
      padding: EdgeInsets.all(48),
      child: content,
    );

    final wave = TextLiquidFill(
      text: '',
      waveColor: SharedColors.alizarin,
      boxBackgroundColor: Colors.transparent,
      boxHeight: 48.0,
    );

    final container = Container(
      child: Column(
        children: [Flexible(child: paddedContent), wave],
      ),
    );

    return Scaffold(
      drawer: DrawerView(Router.SIGN_UP_ROUTE),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(child: container),
    );

  }

}
