import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {

  final String text;

  SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {

    final headerText = Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );

    return Container(
      color: Theme.of(context).dividerColor.withOpacity(0.05),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(children: [headerText]),
    );

  }

}
