import 'package:flutter/widgets.dart';
import 'package:letsattend/router.dart';
import 'package:letsattend/view_models/auth/auth_status.dart';
import 'package:letsattend/view_models/settings_model.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:letsattend/widgets/liquid_animation.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/widgets/modern_input.dart';
import 'package:letsattend/widgets/modern_button.dart';
import 'package:letsattend/models/payload.dart';
import 'package:letsattend/view_models/auth/auth_model.dart';

class SignInView extends StatefulWidget {
  @override
  SignInViewState createState() => SignInViewState();
}

class SignInViewState extends State<SignInView> {

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
    if(emailError != null || passwordError != null) {
      setState(() {
        emailError = null;
        passwordError = null;
      });
    }
  }

  void signIn() async {

    clearErrors();
    final auth = Provider.of<AuthModel>(context, listen: false);

    String email = emailCtrl.text.trim();
    String password = passwordCtrl.text.trim();
    final payload = await auth.signIn(email, password);

    if(payload.hasError) {
      if(payload.errorCode == AuthPayload.ERROR_WRONG_PASSWORD)
        setState(() => passwordError = 'Contraseña incorrecta');
      else if (payload.errorCode == AuthPayload.ERROR_INVALID_EMAIL)
        setState(() => emailError = 'El correo es inválido');
      else if (payload.errorCode == AuthPayload.ERROR_USER_NOT_FOUND)
        setState(() => emailError = 'El usuario no ha sido registrado');
    }
    else
      Navigator.of(context).pop();

  }

  void googleSignIn() async {
    print('Sign In with Google');
    final auth = Provider.of<AuthModel>(context, listen: false);
    final payload = await auth.signInWithGoogle();
    if(payload.hasError)
      showDialog(context: context, child: buildAlert(context));
    else
      Navigator.of(context).pop();
  }

  Widget buildAlert(BuildContext context){

    final textStyle = TextStyle(color: Colors.white);

    final closeButton = FlatButton(
      child: Text('ENTENDIDO'),
      color: Colors.white,
      onPressed: Navigator.of(context).pop,
    );

    return AlertDialog(
      backgroundColor: Colors.red,
      actions: [closeButton],
      title: Text(
        'Alerta',
        style: textStyle,
      ),
      content: Text(
        'No se ha podido iniciar sesión, intente con otra opción.',
        style: textStyle,
      ),
    );

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

    final submitButton = ModernButton(
      'INGRESAR',
      color: SharedColors.alizarin,
      onPressed: signIn,
    );

    final googleButton = ModernButton(
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
        Navigator.of(context).pushNamed(Router.PASSWORD_RESET_ROUTE);
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
      drawer: DrawerView(Router.LOGIN_ROUTE),
      resizeToAvoidBottomInset : false,
    );

  }

}
