import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:letsattend/colors.dart';
import 'package:letsattend/widgets/modern_button.dart';
import 'package:letsattend/widgets/modern_input.dart';


class AuthForm extends StatefulWidget {

  final Function submit;
  final String submitText;
  final bool confirmation;

  AuthForm({
    this.submit,
    this.submitText = 'INGRESAR',
    this.confirmation = true
  });

  @override
  AuthFormState createState() => AuthFormState();

}

class AuthFormState extends State<AuthForm> {

  bool validating = false;

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
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmationCtrl.dispose();
    super.dispose();
  }

  submit(){
//    setState(() => validating = true);
    widget.submit(emailCtrl.text, passwordCtrl.text);
  }

  @override
  Widget build(BuildContext context) {

    final emailField = ModernInput(
      hintText: 'Email',
      errorText: emailError,
      controller: emailCtrl,
      icon: MaterialCommunityIcons.mail_ru,
    );

    final passwordField = ModernInput(
      obscureText: true,
      hintText: 'Contraseña',
      errorText: passwordError,
      controller: passwordCtrl,
      icon: MaterialCommunityIcons.key,
    );

    final confirmationField = ModernInput(
      obscureText: true,
      hintText: 'Confirmación',
      errorText: confirmationError,
      controller: confirmationCtrl,
      icon: MaterialCommunityIcons.chevron_right_circle_outline,
    );

    final submitButton = ModernButton(
      widget.submitText,
      color: FlatUI.midnightBlue,
      onPressed: /*validating ? null :*/ submit,
    );

    final content = [
      emailField,
      SizedBox(height: 16),
      passwordField,
      SizedBox(height: 16),
      widget.confirmation ? confirmationField : SizedBox.shrink(),
      SizedBox(height: widget.confirmation ? 16 : 0),
      submitButton,
    ];

    return Column(
      children: content,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );

  }
}
