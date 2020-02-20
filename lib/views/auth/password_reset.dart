import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:letsattend/router.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/models/payload.dart';
import 'package:letsattend/widgets/modern_text.dart';
import 'package:letsattend/widgets/modern_input.dart';
import 'package:letsattend/widgets/modern_button.dart';
import 'package:letsattend/widgets/liquid_animation.dart';
import 'package:letsattend/view_models/settings_model.dart';
import 'package:letsattend/view_models/auth/auth_model.dart';
import 'package:letsattend/view_models/auth/auth_status.dart';

class PasswordResetView extends StatefulWidget {
  @override
  PasswordResetViewState createState() => PasswordResetViewState();
}

class PasswordResetViewState extends State<PasswordResetView> {

  String emailError;
  final emailCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailCtrl.text = 'july12sali@gmail.com';
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    super.dispose();
  }

  void reset() async {
    final auth = Provider.of<AuthModel>(context, listen: false);
    String email = emailCtrl.text.trim();
    final payload = await auth.resetPassword(email);

    payload.hasError
        ? _displayError(payload.errorCode)
        : Navigator.of(context).pop();
  }

  void _displayError(String errorCode){
    if(errorCode == AuthPayload.ERROR_NETWORK_REQUEST_FAILED) {
      String message = 'Revise la conexión a internet.';
      showDialog(context: context, child: buildAlert(context, message));
    }
    else if (errorCode == AuthPayload.ERROR_INVALID_EMAIL)
      setState(() => emailError = 'El correo es inválido');
    else if (errorCode == AuthPayload.ERROR_USER_NOT_FOUND)
      setState(() => emailError = 'El usuario asociado a este correo no existe');
    else{
      String message = 'No se ha podido enviar la contraseña.';
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

    final auth = Provider.of<AuthModel>(context);
    final settings = Provider.of<SettingsModel>(context);

    final emailField = ModernInput(
      hintText: 'Email',
      errorText: emailError,
      controller: emailCtrl,
      keyboardType: TextInputType.text,
      leading: Icon(MaterialCommunityIcons.at),
    );

    final submitButton = ModernButton(
      'RECUPERAR',
      color: SharedColors.alizarin,
      onPressed: reset,
    );

    final auxText = Text(
      'Recordé mi contraseña',
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

    final wave = Hero(
      tag: 'liquid-animation',
      child: LiquidAnimation(
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
      title: ModernText('CONTRASEÑA'),
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
      body: SafeArea(child: container),
      drawer: DrawerView(Router.PASSWORD_RESET_ROUTE),
      appBar: appBar,
    );

  }

}