import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/models/person.dart';

class ItemPeople extends StatelessWidget {

  final List<Person> people;

  const ItemPeople({
    Key key,
    @required this.people,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final personInitials = (Person person) => Text(
      person.getInitial(),
      style: TextStyle(fontSize: 10, color: Colors.white),
    );

    final personAvatar = (Person person) => CircleAvatar(
      radius: 9,
      backgroundColor: person.getColor(),
      child: personInitials(person),
    );

    List<Widget> peopleWidgets = <Widget>[];

    for (int i = 0; i < people.length; i++){

      peopleWidgets.add(Container(
          margin: EdgeInsets.only(left: i * 14.0),
          child: personAvatar(people[i])
      ));

    }

    String mainPerson = people[0].name;
    String morePeople = people.length > 1 ? 'y ${people.length - 1} más' : '';

    final description = Text(
      'por $mainPerson $morePeople',
      style: TextStyle(fontSize: 12)
    );

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
