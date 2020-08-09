import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {

  final String title;
  final String subtitle;

  EmptyView(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {

    /// The text is big due to being directly in a container
    final titleStyle = TextStyle(
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none,
    );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: titleStyle,),
        Text(subtitle)
      ],
    );

    final container = Container(
      height: 300,
      child: Center(child: content,)
    );

    return container;

  }
}
