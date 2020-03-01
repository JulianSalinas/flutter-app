import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:letsattend/blocs/auth_bloc.dart';
import 'package:letsattend/blocs/settings_bloc.dart';
import 'package:letsattend/views/drawer/drawer_clipper.dart';
import 'package:letsattend/views/drawer/drawer_content.dart';

class DrawerView extends StatelessWidget {

  final String currentRoute;
  DrawerView(this.currentRoute);

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final settings = Provider.of<SettingsBloc>(context);

    final safeContainer = SafeArea(
      child: DrawerContent(currentRoute),
    );

    final drawerContainer = Container(
      width: 300,
      padding: EdgeInsets.only(left: 16, right: 40),
      child: safeContainer,
    );

    final baseColor = settings.nightMode
        ? theme.canvasColor
        : Colors.white;

    final transparentDecoration = BoxDecoration(
      color: baseColor.withOpacity(settings.nightMode ? 0.6 : 0.9),
    );

    final transparentFilter = BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
      child: Container(decoration: transparentDecoration),
    );

    final transparentDrawerContainer = Stack(
      children: [transparentFilter, drawerContainer],
    );

    final drawer = Drawer(
      child: transparentDrawerContainer,
    );

    final drawerClipPath = ClipPath(
      clipper: DrawerClipper(),
      child: drawer,
    );

    return Theme(
      data: theme.copyWith(canvasColor: Colors.transparent),
      child: drawerClipPath,
    );

  }

}
