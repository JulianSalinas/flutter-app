import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/models/payload.dart';
import 'package:letsattend/widgets/modern_input.dart';
import 'package:letsattend/widgets/modern_button.dart';
import 'package:letsattend/view_models/auth/auth_model.dart';

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

    if(payload.hasError) {
      if (payload.errorCode == AuthPayload.ERROR_INVALID_EMAIL)
        setState(() => emailError = 'El correo es inválido');
      else if (payload.errorCode == AuthPayload.ERROR_USER_NOT_FOUND)
        setState(() => emailError = 'El usuario no ha sido encontrado');
    }

  }

  @override
  Widget build(BuildContext context) {

    final headline = TypewriterAnimatedTextKit(
      speed: Duration(milliseconds: 200),
      text: ['RECUPERA', 'TU CONTRASEÑA'],
      textStyle: Theme.of(context).textTheme.headline,
    );

    final emailField = ModernInput(
      hintText: 'Email',
      errorText: emailError,
      controller: emailCtrl,
      keyboardType: TextInputType.text,
      leading: Icon(MaterialCommunityIcons.at),
    );

    final submitButton = ModernButton(
      'RECUPERAR',
      color: SharedColors.midnightBlue,
      onPressed: reset,
    );

    final auxText = Text(
      'He recordado mi contraseña',
      style: TextStyle(color: SharedColors.peterRiver),
    );

    final auxButton = MaterialButton(
      child: auxText,
      onPressed: Navigator.of(context).pop,
    );

    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        headline,
        SizedBox(height: 16),
        emailField,
        SizedBox(height: 16),
        submitButton,
        auxButton
      ],
    );

    final container = Container(
      padding: EdgeInsets.all(48),
      child: content,
    );

    return Scaffold(body: SafeArea(child: container));

  }

}