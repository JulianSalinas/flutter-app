import 'package:flutter/material.dart';
import 'package:letsattend/router/routes.dart';
import 'package:letsattend/widgets/custom/formal_text.dart';
import 'package:letsattend/widgets/custom/colored_flex.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none,
    );

    final content = Center(
      child: Text('ABOUT', style: textStyle),
    );

    final body = Container(
      child: content,
    );

    final appBarLeading = IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: Navigator.of(context).pop,
    );

    final appBar = AppBar(
      title: FormalText('Acerca de'),
      centerTitle: true,
      leading: appBarLeading,
      flexibleSpace: ColoredFlex(),
    );

    return Scaffold(
      drawer: DrawerView(Routes.aboutRoute),
      appBar: appBar,
      body: body,
    );
  }
}
