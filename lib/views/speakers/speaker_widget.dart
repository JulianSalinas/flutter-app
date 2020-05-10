import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/models/speaker.dart';

class SpeakerWidget extends StatelessWidget {

  final Function onTap;
  final Speaker speaker;

  const SpeakerWidget({
    Key key,
    @required this.onTap,
    @required this.speaker,
  }) : super(key: key);

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

    final subtitle = speaker.country != null
        ? speaker.country
        : 'Desde ${speaker.about}';

    final subtitleText = Text(
      subtitle,
      overflow: TextOverflow.ellipsis,
    );

    return ListTile(
      leading: avatar,
      title: Text(speaker.name),
      subtitle: subtitleText,
      onTap: onTap,
    );

  }

}
