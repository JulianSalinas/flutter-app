import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:jiffy/jiffy.dart';
import 'package:letsattend/models/post.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/widgets/common/browser_view.dart';
import 'package:letsattend/widgets/common/preview_image.dart';
import 'package:letsattend/widgets/common/preview_link.dart';
import 'package:letsattend/widgets/custom/colored_flex.dart';
import 'package:letsattend/widgets/custom/formal_text.dart';
import 'package:letsattend/widgets/custom/rounded_button.dart';
import 'package:letsattend/widgets/custom/rounded_input.dart';

class CreatePost extends StatefulWidget {


  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    final form =  Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[

            Text('Título'),
            RoundedInput(
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),

            SizedBox(height: 16,),

            Text('Acceso URL'),
            RoundedInput(
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),

            SizedBox(height: 16,),

            Text('Contenido'),
            RoundedInput(
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              minLines: 10,
            ),

            SizedBox(height: 16,),

            RoundedButton(
              'Finalizar',
              color: SharedColors.alizarin,
              onPressed: () {
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.

                  ScaffoldMessenger
                      .of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
            ),
          ],
        ),
      ),
    );

    final body = Container(
      child: form,
    );

    final appBar = AppBar(
      title: FormalText('Nueva Noticia'),
      centerTitle: true,
      flexibleSpace: ColoredFlex(),
    );

    return Scaffold(
      appBar: appBar,
      body: body,
    );

  }
}
