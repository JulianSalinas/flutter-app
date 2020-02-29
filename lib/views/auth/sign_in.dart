import 'package:letsattend/models/auth/auth_code.dart';
import 'package:letsattend/widgets/custom/formal_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:letsattend/router/routes.dart';
import 'package:letsattend/services/auth/auth_status.dart';
import 'package:letsattend/blocs/settings_bloc.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:letsattend/widgets/animation/liquid_bottom.dart';

import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/widgets/custom/rounded_input.dart';
import 'package:letsattend/widgets/custom/rounded_button.dart';
import 'package:letsattend/models/auth/auth_payload.dart';
import 'package:letsattend/blocs/auth/auth_bloc.dart';

class SignInView extends StatefulWidget {
  @override
  SignInViewState createState() => SignInViewState();
}

class SignInViewState extends State<SignInView> {

  bool obscurePassword = true;

  String emailError;
  String passwordError;

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailCtrl.text = 'july12sali@gmail.com';
    passwordCtrl.text = 'telacreistewe';
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  void clearErrors(){
    if(emailError == null && passwordError == null)
      return;
    setState(() {
      emailError = null;
      passwordError = null;
    });
  }

  void signIn() async {
    clearErrors();
    final auth = Provider.of<AuthBloc>(context, listen: false);

    String email = emailCtrl.text.trim();
    String password = passwordCtrl.text.trim();
    final payload = await auth.signIn(email, password);

    payload.hasError
      ? _displayError(payload.errorCode)
      : Navigator.of(context).pop();
  }

  void googleSignIn() async {
    final auth = Provider.of<AuthBloc>(context, listen: false);
    final payload = await auth.signInWithGoogle();

    payload.hasError
        ? _displayError(payload.errorCode)
        : Navigator.of(context).pop();
  }

  void _displayError(String errorCode){
    if(errorCode == AuthCode.ERROR_NETWORK_REQUEST_FAILED) {
      String message = 'Revise la conexión a internet.';
      showDialog(context: context, child: buildAlert(context, message));
    }
    else if(errorCode == AuthCode.ERROR_WRONG_PASSWORD)
      setState(() => passwordError = 'Contraseña incorrecta');
    else if (errorCode == AuthCode.ERROR_INVALID_EMAIL)
      setState(() => emailError = 'El correo es inválido');
    else if (errorCode == AuthCode.ERROR_USER_NOT_FOUND)
      setState(() => emailError = 'El usuario no ha sido registrado');
    else{
      String message = 'No se ha podido iniciar sesión, intente con otra opción.';
      showDialog(context: context, child: buildAlert(context, message));
    }
  }

  Widget buildAlert(BuildContext context, String message){

    final textStyle = TextStyle(color: Colors.white);

    final closeButton = FlatButton(
      child: Text('ENTENDIDO'),
      color: Colors.white,
      onPressed: Navigator.of(context).pop,
    );

    return AlertDialog(
      backgroundColor: Colors.red,
      actions: [closeButton],
      title: Text('Atención', style: textStyle),
      content: Text(message, style: textStyle),
    );

  }

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthBloc>(context);
    final settings = Provider.of<SettingsBloc>(context);

    final emailField = RoundedInput(
      hintText: 'Email',
      errorText: emailError,
      controller: emailCtrl,
      keyboardType: TextInputType.text,
      leading: IconButton(
        icon: Icon(MaterialCommunityIcons.at),
        onPressed: () { },
      ),
    );

    final visibilityIcon = Icon(obscurePassword
        ? MaterialIcons.visibility_off
        : MaterialIcons.visibility,
    );

    final visibilityButton = IconButton(
      icon: visibilityIcon,
      onPressed: () => setState(() => obscurePassword = !obscurePassword),
    );

    final passwordField = RoundedInput(
      obscureText: obscurePassword,
      hintText: 'Contraseña',
      errorText: passwordError,
      controller: passwordCtrl,
      leading: visibilityButton,
      keyboardType: TextInputType.text,
    );

    final submitButton = RoundedButton(
      'INGRESAR',
      color: SharedColors.alizarin,
      onPressed: signIn,
    );

    final googleButton = RoundedButton(
      'Ingresar con Google',
      color: Colors.white,
      textColor: SharedColors.google,
      onPressed: googleSignIn,
      icon: FontAwesome.google,
    );

    final auxText = Text(
      '¿Has olvidado tu contraseña?',
      style: TextStyle(
        color: Theme.of(context).textTheme.body1.color.withOpacity(0.6),
      ),
    );

    final auxButton = MaterialButton(
      child: auxText,
      onPressed: () {
        Navigator.of(context).pushNamed(Routes.PASSWORD_RESET_ROUTE);
      },
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
        if(auth.status != AuthStatus.Authenticating)...[
          submitButton,
          SizedBox(height: 16),
          Text('Ó puedes', textAlign: TextAlign.center),
          SizedBox(height: 16),
          googleButton,
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

    final wave = Hero(
      tag: 'liquid-animation',
      child: LiquidBottom(
        boxHeight: 48,
        waveColor: SharedColors.alizarin,
        boxBackgroundColor: Colors.transparent,
      ),
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
      title: FormalText(
        'Iniciar sesión',
        color: settings.nightMode ? Colors.white : Colors.black,
      ),
      centerTitle: true,
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
      drawer: DrawerView(Routes.LOGIN_ROUTE),
      resizeToAvoidBottomInset : false,
    );

  }

}
