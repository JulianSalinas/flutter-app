import 'dart:ui';
import 'package:letsattend/view_models/settings_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:letsattend/models/user.dart';
import 'package:letsattend/router.dart' as router;
import 'package:letsattend/view_models/auth_model.dart';
import 'package:letsattend/view_models/theme_model.dart';
import 'package:letsattend/views/drawer/drawer_option.dart';
import 'package:letsattend/views/drawer/drawer_user.dart';

class DrawerContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    AuthModel authModel = Provider.of<AuthModel>(context);
    SettingsModel settingsModel = Provider.of<SettingsModel>(context);

    final divider = Divider(
      color: Colors.grey.withOpacity(0.8),
    );

    final emptyUser = User(
      uid: 'loading-user',
      providerId: 'local-app',
    );

    final drawerUser = FutureBuilder<User>(
      future: authModel.user,
      builder: (context, snapshot) => DrawerUser(
        user: snapshot.hasData ? snapshot.data : emptyUser,
      ),
    );

    final nightModeSwitch = Switch(
      value: settingsModel.nightMode,
      onChanged: (bool active) => settingsModel.nightMode = active,
    );

    final nightModeContent = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(MaterialCommunityIcons.weather_night),
        SizedBox(width: 12.0),
        Text('Modo oscuro', style: TextStyle(fontSize: 16.0)),
        Spacer(),
        nightModeSwitch,
      ],
    );

    final content = Column(
      children: [
        drawerUser,
        SizedBox(height: 24.0),
        DrawerOption(
          icon: Icons.home,
          title: 'Principal',
          route: router.HomeRoute,
        ),
        divider,
        DrawerOption(
          icon: MaterialCommunityIcons.calendar,
          title: 'Cronograma',
          route: router.ScheduleRoute,
        ),
        divider,
        DrawerOption(
          icon: Icons.message,
          title: 'Chat',
          badge: '+15',
          route: router.ChatRoute,
        ),
        divider,
        DrawerOption(
          icon: Icons.notifications,
          title: 'Noticias',
          badge: '+5',
          route: router.NewsRoute,
        ),
        divider,
        DrawerOption(
          icon: Icons.people,
          title: 'Expositores',
          route: router.SpeakersRoute,
        ),
        divider,
        DrawerOption(
          icon: Icons.settings,
          title: 'Configuración',
          route: router.SettingsRoute,
        ),
        divider,
        DrawerOption(
          icon: Icons.email,
          title: 'Contácto',
          route: router.AboutRoute,
        ),
        divider,
        Container(child: nightModeContent)
      ],
    );

    return SingleChildScrollView(child: content);
  }
}
