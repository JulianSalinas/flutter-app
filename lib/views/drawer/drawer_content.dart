import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:letsattend/router/routes.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/views/drawer/drawer_user.dart';
import 'package:letsattend/views/drawer/drawer_option.dart';
import 'package:letsattend/blocs/settings_bloc.dart';
import 'package:letsattend/blocs/auth/auth_bloc.dart';

class DrawerContent extends StatelessWidget {

  final String route;

  DrawerContent(this.route);

  @override
  Widget build(BuildContext context) {

    AuthBloc auth = Provider.of<AuthBloc>(context);
    SettingsBloc settings = Provider.of<SettingsBloc>(context);

    final pushReplacement = (String route) {
      Navigator.pop(context);
      if (this.route != route)
        Navigator.pushReplacementNamed(context, route);
    };

    final closeFunction = () async {
      Navigator.of(context).pop();
      await auth.signOut();
    };

    final closeButton = IconButton(
      icon: Icon(Icons.power_settings_new),
      onPressed: closeFunction,
    );

    final closeContainer = Container(
      alignment: Alignment.centerRight,
      child: closeButton,
    );

    final optionDivider = Divider(
      color: Colors.grey.withOpacity(0.8),
    );

    final defaultUser = User(
      id: 'default',
      isAnonymous: true,
    );

    final drawerUser = DrawerUser(
      user: auth.user ?? defaultUser,
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

    final nightModeContainer = Container(
      child: nightModeContent,
    );

    final closeSpace = auth.user == null
        ? SizedBox(height: 48)
        : closeContainer;

    final authOption = DrawerOption(
      icon: MaterialCommunityIcons.login_variant,
      title: 'Ingresar',
      onTap: () => pushReplacement(Routes.AUTH_ROUTE),
    );

    final homeOption = DrawerOption(
      icon: Icons.home,
      title: 'Principal',
      onTap: () => pushReplacement(Routes.HOME_ROUTE),
    );

    final scheduleOption = DrawerOption(
      icon: MaterialCommunityIcons.calendar,
      title: 'Cronograma',
      onTap: () => pushReplacement(Routes.SCHEDULE_ROUTE),
    );

    final chatOption = DrawerOption(
      icon: Icons.message,
      title: 'Chat',
      badge: '+15',
      onTap: () => pushReplacement(Routes.CHAT_ROUTE),
    );

    final newsOption = DrawerOption(
      icon: Icons.notifications,
      title: 'Noticias',
      badge: '+5',
      onTap: () => pushReplacement(Routes.NEWS_ROUTE),
    );

    final speakersOption = DrawerOption(
      icon: Icons.people,
      title: 'Expositores',
      onTap: () => pushReplacement(Routes.SPEAKERS_ROUTE),
    );

    final aboutOption = DrawerOption(
      icon: Icons.email,
      title: 'Acerca de',
      onTap: () => Navigator.pushNamed(context, Routes.ABOUT_ROUTE),
    );

    final settingsOption = DrawerOption(
      icon: Icons.settings,
      title: 'Configuración',
      onTap: () => Navigator.pushNamed(context, Routes.SETTINGS_ROUTE),
    );

    final userLoggedOptions = [
      homeOption,
      optionDivider,
      scheduleOption,
      optionDivider,
      chatOption,
      optionDivider,
      newsOption,
      optionDivider,
      speakersOption,
      optionDivider,
    ];

    final userNotLogged = [
      authOption,
      optionDivider,
    ];

    final availableOptions = auth.user != null
        ? userLoggedOptions
        : userNotLogged;

    final content = Column(
      children: [
        closeSpace,
        drawerUser,
        SizedBox(height: 24.0),
        ...availableOptions,
        aboutOption,
        optionDivider,
        settingsOption,
        optionDivider,
        nightModeContainer,
      ],
    );

    return SingleChildScrollView(child: content);

  }

}
