import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/core/models/speaker.dart';

class SpeakerWidget extends StatelessWidget {

  final Speaker person;

  const SpeakerWidget({
    Key key,
    @required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initials = Text(
      person.initials,
      style: TextStyle(fontSize: 14, color: Colors.white),
    );

    final avatar = CircleAvatar(
      radius: 18,
      backgroundColor: person.color,
      child: initials,
    );

    final subtitle = person.university != null
        ? person.university
        : 'Desde ${person.country}';

    return ListTile(
      leading: avatar,
      title: Text(person.name),
      subtitle: Text(
        subtitle,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () => print('Showing ${person.name}\' details'),
    );
  }

}
