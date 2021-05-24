import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/views/person/person_view.dart';

class SpeakerWidget extends StatelessWidget {

  final Speaker speaker;

  SpeakerWidget({
    required Key key,
    required this.speaker,
  }) : super(key: key);

  /// Opens PersonView widget with the speaker's information
  openDetail(BuildContext context) {

    final route =  MaterialPageRoute(
      builder: (_) => PersonView(speaker: speaker)
    );
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {

    final initials = Text(
      speaker.initials,
      style: TextStyle(fontSize: 14, color: Colors.white),
    );

    final avatar = CircleAvatar(
      radius: 18,
      backgroundColor: speaker.color,
      child: initials,
    );

    final heroAvatar = Hero(
      child: avatar,
      tag: 'avatar${speaker.key}',
    );

    final subtitle = speaker.country != null
        ? speaker.country
        : 'Desde ${speaker.about}';

    final subtitleText = Text(
      subtitle!,
      overflow: TextOverflow.ellipsis,
    );

    final heroTitle = Hero(
      tag: 'name${speaker.key}',
      child: Material(child: Text(speaker.name), color: Colors.transparent),
    );

    return ListTile(
      leading: heroAvatar,
      title: heroTitle,
      subtitle: subtitleText,
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () => openDetail(context),
    );

  }

}
