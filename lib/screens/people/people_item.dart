import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/models/person.dart';

class PeopleItem extends StatelessWidget {

  final Person person;

  const PeopleItem({
    Key key,
    @required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final initials = Text(
      person.getInitial(),
      style: TextStyle(fontSize: 14, color: Colors.white),
    );

    final avatar = CircleAvatar(
      radius: 18,
      backgroundColor: person.getColor(),
      child: initials,
    );

    return ListTile(
      leading: avatar,
      title: Text(person.name),
      subtitle: Text(person.about),
      onTap: () => print('Showing ${person.name}\' details'),
    );

  }

}