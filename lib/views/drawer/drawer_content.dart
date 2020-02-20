import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:letsattend/router.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/views/drawer/drawer_user.dart';
import 'package:letsattend/views/drawer/drawer_option.dart';
import 'package:letsattend/view_models/settings_model.dart';
import 'package:letsattend/view_models/auth/auth_model.dart';

class DrawerContent extends StatelessWidget {

  final String currentRoute;
  DrawerContent(this.currentRoute);

  @override
  Widget build(BuildContext context) {

    AuthModel auth = Provider.of<AuthModel>(context);
    SettingsModel settings = Provider.of<SettingsModel>(context);

    final closeFunction = () async {
      if(Scaffold.of(context).isDrawerOpen){
        Navigator.of(context).pop();
        await auth.signOut();
      }
    };

    final closeButton = IconButton(
      icon: Icon(Icons.power_settings_new),
      onPressed: closeFunction,
    );

    final drawerClose = Container(
      alignment: Alignment.centerRight,
      child: closeButton,
    );

    final divider = Divider(
      color: Colors.grey.withOpacity(0.8),
    );

    final emptyUser = User(
      uid: 'loading-user',
      providerId: 'local-app',
      isAnonymous: true,
    );

    final drawerUser = DrawerUser(
      user: auth.user == null ? emptyUser : auth.user,
    );

    final nightModeSwitch = Switch(
      value: settings.nightMode,
      onChanged: (bool active) => settings.nightMode = active,
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
        if (auth.user == null)
          SizedBox(height: 48,),
        if (auth.user != null)
          drawerClose,
        drawerUser,
        SizedBox(height: 24.0),
        if(auth.user != null) ...[
          DrawerOption(
            icon: Icons.home,
            title: 'Principal',
            route: Router.HOME_ROUTE,
          ),
          divider,
          DrawerOption(
            icon: MaterialCommunityIcons.calendar,
            title: 'Cronograma',
            route: Router.SCHEDULE_ROUTE,
          ),
          divider,
          DrawerOption(
            icon: Icons.message,
            title: 'Chat',
            badge: '+15',
            route: Router.CHAT_ROUTE,
          ),
          divider,
          DrawerOption(
            icon: Icons.notifications,
            title: 'Noticias',
            badge: '+5',
            route: Router.NEWS_ROUTE,
          ),
          divider,
          DrawerOption(
            icon: Icons.people,
            title: 'Expositores',
            route: Router.SPEAKERS_ROUTE,
          ),
          divider,
        ],
        DrawerOption(
          icon: Icons.settings,
          title: 'Configuración',
          route: Router.SETTINGS_ROUTE,
        ),
        divider,
        DrawerOption(
          icon: Icons.email,
          title: 'Contácto',
          route: Router.ABOUT_ROUTE,
        ),
        divider,
        Container(child: nightModeContent)
      ],
    );

    return SingleChildScrollView(child: content);

  }

}
