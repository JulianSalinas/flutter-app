import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/view_models/auth/auth_model.dart';
import 'package:provider/provider.dart';

class DrawerUser extends StatelessWidget {

  final User user;

  DrawerUser({
    @required this.user,
  }) : assert(user != null);

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthModel>(context);

    final closeButton = IconButton(
      icon: Icon(Icons.power_settings_new),
      onPressed: () => auth.signOut(),
    );

    final closeSession = Container(
      alignment: Alignment.centerRight,
      child: closeButton,
    );

    final hasPhoto = user.photoUrl != null;

    final circleAvatar = CircleAvatar(
      radius: 40,
      backgroundColor: user.color,
      backgroundImage: hasPhoto
          ? NetworkImage(user.photoUrl)
          : AssetImage('assets/panda.png'),
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
      user.name ?? 'Anónimo',
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
    );

    final drawerEmail = Text(user.email ?? 'Bienvenido al EDEPA');

    return Column(
      children: [
        closeSession,
        drawerAvatar,
        SizedBox(height: 12.0),
        drawerName,
        drawerEmail,
      ],
    );

  }

}
