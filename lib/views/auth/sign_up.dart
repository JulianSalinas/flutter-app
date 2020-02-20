import 'package:letsattend/router.dart';
import 'package:letsattend/view_models/auth/auth_status.dart';
import 'package:letsattend/view_models/settings_model.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:letsattend/widgets/liquid_animation.dart';
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
  void initState() {
    super.initState();
    emailCtrl.text = 'july12sali@gmail.com';
    passwordCtrl.text = 'telacreistewe';
    confirmationCtrl.text = 'telacreistewe';
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmationCtrl.dispose();
    super.dispose();
  }

  void clearErrors() {
    if (emailError != null ||
        passwordError != null ||
        confirmationError != null) {
      setState(() {
        emailError = null;
        passwordError = null;
        confirmationError = null;
      });
    }
  }

  void signUp() async {

    clearErrors();
    final auth = Provider.of<AuthModel>(context, listen: false);

    String email = emailCtrl.text.trim();
    String password = passwordCtrl.text.trim();
    String confirmation = confirmationCtrl.text.trim();

    if (password != confirmation){
      final message = 'Debes escribir la contraseña nuevamente';
      setState(() => confirmationError = message);
      return;
    }

    final payload = await auth.signUp(email, password);

    if (payload.hasError) {
      if (payload.errorCode == AuthPayload.ERROR_EMAIL_ALREADY_IN_USE)
        setState(() => emailError = 'El usuario ya está registrado');
      else if (payload.errorCode == AuthPayload.ERROR_INVALID_EMAIL)
        setState(() => emailError = 'El correo es inválido');
    }
    else {
      Navigator.of(context).pop();
    }

  }

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthModel>(context);
    final settings = Provider.of<SettingsModel>(context);

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
      style: TextStyle(
        color: Theme.of(context).textTheme.body1.color.withOpacity(0.6),
      ),
    );

    final auxButton = MaterialButton(
      child: auxText,
      onPressed: Navigator.of(context).pop,
    );

    final logo = Hero(
      tag: 'app-logo',
      child: FlutterLogo(size: 132, colors: Colors.deepOrange),
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
        if(auth.status != AuthStatus.Authenticating)...[
          submitButton,
          auxButton,
        ]
        else ... [
          SizedBox(height: 16),
          Center(child: CircularProgressIndicator()),
        ],
        SizedBox(height: 48),
      ],
    );

    final scrollableContent = Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(48),
        child: content,
      ),
    );

    final wave = LiquidAnimation(
      boxHeight: 48,
      waveColor: SharedColors.alizarin,
      boxBackgroundColor: Colors.transparent,
    );

    final container = Container(
      constraints: BoxConstraints.expand(),
      child: Stack(
        children: [
          scrollableContent,
          Positioned(
            bottom: 0,
            child: wave,
          ),
        ],
      ),
    );

    final appBar = AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: Navigator.of(context).pop,
      ),
      iconTheme: IconThemeData(
        color: settings.nightMode ? Colors.white : Colors.black,
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: SafeArea(child: container),
      drawer: DrawerView(Router.SIGN_UP_ROUTE),
      resizeToAvoidBottomInset : false,
    );

  }

}
