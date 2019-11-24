import 'package:flutter/material.dart';


class Shortcut extends StatelessWidget {

    final String text;
    final IconData icon;

    Shortcut({
        Key key,
        @required this.icon,
        @required this.text
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Column(
            children: <Widget>[
                Center(
                    child: Container(
                        child: Icon(
                            icon,
                            size: 32.0,
                        ),
                        padding: EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).textTheme.body1.color,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(48.0)
                            )
                        ),
                    )
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(text),
                )

            ]
        );
    }

}