import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/models/speaker.dart';

class ItemPeople extends StatelessWidget {
  final List<Speaker> speakers;

  const ItemPeople({
    Key key,
    @required this.speakers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final personInitials = (Speaker person) => Text(
          person.initial,
          style: TextStyle(fontSize: 10, color: Colors.white),
        );

    final personAvatar = (Speaker person) => CircleAvatar(
          radius: 9,
          backgroundColor: person.color,
          child: personInitials(person),
        );

    List<Widget> peopleWidgets = <Widget>[];

    for (int i = 0; i < speakers.length; i++) {
      peopleWidgets.add(Container(
        margin: EdgeInsets.only(left: i * 14.0),
        child: personAvatar(speakers[i]),
      ));
    }

    String mainPerson = speakers[0].name;
    String morePeople = speakers.length > 1 ? 'y ${speakers.length - 1} más' : '';

    final description =
        Text('por $mainPerson $morePeople', style: TextStyle(fontSize: 12));

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Stack(children: peopleWidgets.toList()),
        SizedBox(width: 8),
        Opacity(opacity: 0.6, child: description),
      ],
    );
  }
}
