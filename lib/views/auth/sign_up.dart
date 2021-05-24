import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:letsattend/router/routes.dart';
import 'package:letsattend/shared/codes.dart';
import 'package:letsattend/shared/status.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/blocs/settings_bloc.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';

import 'package:letsattend/blocs/auth_bloc.dart';
import 'package:letsattend/widgets/custom/formal_text.dart';
import 'package:letsattend/widgets/custom/rounded_input.dart';
import 'package:letsattend/widgets/custom/rounded_button.dart';
import 'package:letsattend/widgets/animation/liquid_bottom.dart';

class SignUpView extends StatefulWidget {
  @override
  SignUpViewState createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView> {

  String? emailError;
  String? passwordError;
  String? confirmationError;

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
    if (emailError == null &&
        passwordError == null &&
        confirmationError == null) return;
    setState(() {
      emailError = null;
      passwordError = null;
      confirmationError = null;
    });
  }

  void signUp() async {

    clearErrors();
    final auth = Provider.of<AuthBloc>(context, listen: false);

    String email = emailCtrl.text.trim();
    String password = passwordCtrl.text.trim();
    String confirmation = confirmationCtrl.text.trim();

    if (password != confirmation){
      final message = 'Debes escribir la contraseña nuevamente';
      setState(() => confirmationError = message);
      return;
    }

    final payload = await auth.signUp(email, password);

    payload.hasError
        ? _displayError(payload.errorCode ?? "unknown")
        : Navigator.of(context).pop();

  }

  void _displayError(String errorCode){
    if(errorCode == Codes.networkRequestFailed) {
      String message = 'Revise la conexión a internet.';
      showDialog(context: context, builder: (context) => buildAlert(context, message));
    }
    else if (errorCode == Codes.emailAlreadyInUse)
      setState(() => emailError = 'El usuario ya está registrado');
    else if (errorCode == Codes.invalidEmail)
      setState(() => emailError = 'El correo es inválido');
    else{
      String message = 'No se ha podido registrar, ';
      message += 'intente con otra opción ingresar con Google';
      showDialog(context: context, builder: (context) => buildAlert(context, message));
    }
  }

  Widget buildAlert(BuildContext context, String message){

    final textStyle = TextStyle(color: Colors.white);

    final closeButton = TextButton(
      child: Text('ENTENDIDO'),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
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

    var emailField = RoundedInput(
      hintText: 'Email',
      controller: emailCtrl,
      keyboardType: TextInputType.text,
      leading: Icon(MaterialCommunityIcons.at),
    );

    if (emailError != null)

       emailField = RoundedInput(
        hintText: 'Email',
        errorText: emailError!,
        controller: emailCtrl,
        keyboardType: TextInputType.text,
        leading: Icon(MaterialCommunityIcons.at),
      );

    var passwordField = RoundedInput(
      obscureText: true,
      hintText: 'Contraseña',
      maxLines: 1,
      controller: passwordCtrl,
      keyboardType: TextInputType.text,
      leading: Icon(MaterialCommunityIcons.key),
    );

    if (passwordError != null)

      passwordField = RoundedInput(
        obscureText: true,
        hintText: 'Contraseña',
        maxLines: 1,
        errorText: passwordError!,
        controller: passwordCtrl,
        keyboardType: TextInputType.text,
        leading: Icon(MaterialCommunityIcons.key),
      );

    var confirmationField = RoundedInput(
      obscureText: true,
      hintText: 'Confirmar contraseña',
      maxLines: 1,
      controller: confirmationCtrl,
      keyboardType: TextInputType.text,
      leading: Icon(AntDesign.lock),
    );

    if (confirmationError != null)

      confirmationField = RoundedInput(
        obscureText: true,
        hintText: 'Confirmar contraseña',
        maxLines: 1,
        controller: confirmationCtrl,
        keyboardType: TextInputType.text,
        leading: Icon(AntDesign.lock),
      );

    final submitButton = RoundedButton(
      'REGISTRARSE',
      color: SharedColors.alizarin,
      onPressed: signUp,
    );

    final auxText = Text(
      'Ya tengo una cuenta',
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyText2?.color?.withOpacity(0.6),
      ),
    );

    final auxButton = MaterialButton(
      child: auxText,
      onPressed: Navigator.of(context).pop,
    );

    final logo = Hero(
      tag: 'app-logo',
      child: FlutterLogo(size: 132),
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
        if(auth.status != Status.Authenticating)...[
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
        'Registrarse',
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
      drawer: DrawerView(Routes.signUpRoute),
      resizeToAvoidBottomInset : false,
    );

  }

}
