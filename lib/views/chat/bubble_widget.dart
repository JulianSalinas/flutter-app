import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:letsattend/locator.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/models/person.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/models/message.dart';
import 'package:letsattend/view_models/user_model.dart';
import 'package:letsattend/view_models/settings_model.dart';

class BubbleWidget extends StatelessWidget {

  final bool isOwned;
  final bool startSequence;
  final bool useTimestamp;
  final Message message;

  BubbleWidget({
    Key key,
    this.isOwned = true,
    this.startSequence = true,
    this.useTimestamp = true,
    @required this.message,
  }) : super(key: key ?? Key(message.key));

  @override
  Widget build(BuildContext context) {

    SettingsModel settings = Provider.of<SettingsModel>(context);
    UserModel userModel = locator<UserModel>();

    final bubbleGradient = LinearGradient(
      colors: isOwned
          ? SharedColors.midnightCity
          : settings.colors ?? settings.nightMode
          ? SharedColors.flareOrange
          : SharedColors.flareOrange
    );

    final timeWithName = Text(
      '${isOwned ? '' : message.senderName}${isOwned ? '': ', '}'
          '${Jiffy(DateTime.fromMicrosecondsSinceEpoch(message.timestamp))
          .format('hh:mm aa')
          .toLowerCase()}',
      style: TextStyle(fontSize: 10.0),
    );

    final messageContent = Text(
      message.content,
      style: TextStyle(color: !isOwned ? Colors.white : null),
    );

    final bubbleBorderRadius = BorderRadius.only(
      topLeft: Radius.circular(isOwned ? 16 : 0),
      topRight: Radius.circular(isOwned ? 0 : 16),
      bottomLeft: Radius.circular(16),
      bottomRight: Radius.circular(16),
    );

    final bubbleDecoration = BoxDecoration(
      color: settings.nightMode
          ? null
          : isOwned
          ? Theme.of(context).disabledColor.withOpacity(0.05)
          : null,
      borderRadius: bubbleBorderRadius,
      gradient: settings.nightMode
          ? bubbleGradient
          : isOwned
          ? null
          : bubbleGradient,
    );

    final boxConstraints = BoxConstraints(
      minWidth: 128,
      maxWidth: 276,
    );

    final bubble = Container(
      child: messageContent,
      padding: EdgeInsets.all(12.0),
      decoration: bubbleDecoration,
      constraints: boxConstraints,
    );

    Person person = Person(message.senderName);

    final personInitials = Text(
      person.initials,
      style: TextStyle(fontSize: 8, color: Colors.white),
    );

    final lazyAvatar = FutureBuilder(
      future: userModel.getUserById(message.senderId),
      builder: (context, snapshot) {
        User user = snapshot.data;
        return CircleAvatar(
          radius: 12,
          backgroundColor: person.color,
          backgroundImage: snapshot.hasData
              && user.photoUrl != null
              ? NetworkImage(user?.photoUrl)
              : null,
          child: snapshot.hasData
              && user.photoUrl != null
              ? null
              : personInitials,
        );
      },
    );

    final avatarContainer = Container(
      margin: EdgeInsets.only(right: 8),
      child: lazyAvatar,
    );

    final content = Column(
      crossAxisAlignment: isOwned
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        if(startSequence)...[timeWithName, SizedBox(height: 8)],
        bubble,
      ],
    );

    final timestampText = Text(
        Jiffy(DateTime.fromMillisecondsSinceEpoch(message.timestamp))
            .format('EEEE d, yyy'),
      style: TextStyle(fontSize: 10.0),
    );

    final timestampContainer = Container(
      margin: EdgeInsets.only(bottom: 12),
      child: timestampText,
    );

    final container = Row(
      mainAxisAlignment: isOwned
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        !isOwned && startSequence ? avatarContainer : SizedBox(width: 32),
        content,
      ],
    );

    return Column(
      children: [
        if(useTimestamp) timestampContainer,
        container,
      ],
    );

  }

}
