import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/models/message.dart';
import 'package:letsattend/models/person.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/view_models/settings_model.dart';
import 'package:letsattend/view_models/user_model.dart';
import 'package:provider/provider.dart';

class BubbleWidget extends StatelessWidget {

  final bool isOwned;
  final Message message;

  BubbleWidget({
    Key key,
    this.isOwned = true,
    @required this.message,
  }) : super(key: key ?? Key(message.key));

  @override
  Widget build(BuildContext context) {

    SettingsModel settingsModel = Provider.of<SettingsModel>(context);
    UserModel userModel = locator<UserModel>();

    final gradient = LinearGradient(
      colors: isOwned
          ? SharedColors.midnightCity
          : settingsModel.colors ?? settingsModel.nightMode
          ? SharedColors.kashmir
          : SharedColors.flareOrange
    );

    final timeText = Text(
      '${message.senderName}, '
          '${Jiffy(DateTime.fromMicrosecondsSinceEpoch(message.timestamp))
          .format('hh:mm aa')
          .toLowerCase()}',
      style: TextStyle(fontSize: 10.0),
    );

    final spaceText = Text(
      message.content,
      style: TextStyle(color: !isOwned ? Colors.white : null),
    );

    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(isOwned ? 16 : 0),
      topRight: Radius.circular(isOwned ? 0 : 16),
      bottomLeft: Radius.circular(16),
      bottomRight: Radius.circular(16),
    );

    final boxDecoration = BoxDecoration(
      color: settingsModel.nightMode
          ? null
          : isOwned
          ? Theme.of(context).disabledColor.withOpacity(0.05)
          : null,
      borderRadius: borderRadius,
      gradient: settingsModel.nightMode
          ? gradient
          : isOwned
          ? null
          : gradient,
    );

    final boxConstraints = BoxConstraints(
      minWidth: 128,
      maxWidth: 276,
    );

    final bubble = Container(
      child: spaceText,
      padding: EdgeInsets.all(12.0),
      decoration: boxDecoration,
      constraints: boxConstraints,
    );

    Person person = Person(message.senderName);

    final initials = Text(
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
              : initials,
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
        timeText,
        SizedBox(height: 8),
        bubble,
      ],
    );

    return Row(
      mainAxisAlignment: isOwned
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [if (!isOwned) avatarContainer, content],
    );

  }

}
