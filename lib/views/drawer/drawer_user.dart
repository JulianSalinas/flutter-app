import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/shared/colors.dart';

class DrawerUser extends StatelessWidget {

  final AppUser user;

  DrawerUser({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {

    final hasPhoto = user.photoUrl != null;

    var circleAvatar = CircleAvatar(
      radius: 40,
      backgroundColor: user.color,
      backgroundImage: AssetImage('assets/avatar/penguin.png'),
    );

    if (hasPhoto)

      circleAvatar = CircleAvatar(
        radius: 40,
        backgroundColor: user.color,
        backgroundImage: NetworkImage(user.photoUrl!),
      );

    final avatarDecoration = BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(colors: SharedColors.sunrise),
    );

    final drawerAvatar = Container(
      height: 90,
      alignment: Alignment.center,
      decoration: avatarDecoration,
      child: circleAvatar,
    );

    final drawerName = Text(
      user.isLogged ? user.name : 'Bienvenido',
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
    );

    final drawerEmail = Text(user.email ?? 'Bienvenido al EDEPA');

    return Column(
      children: [
        drawerAvatar,
        SizedBox(height: 12.0),
        drawerName,
        if (!user.isAnonymous) drawerEmail,
      ],
    );

  }

}
