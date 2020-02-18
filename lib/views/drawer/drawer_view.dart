import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:letsattend/view_models/settings_model.dart';
import 'package:letsattend/views/drawer/drawer_clipper.dart';
import 'package:letsattend/views/drawer/drawer_content.dart';

class DrawerView extends StatelessWidget {

  final String currentRoute;
  DrawerView(this.currentRoute);

  @override
  Widget build(BuildContext context) {

    SettingsModel settingsModel = Provider.of<SettingsModel>(context);

    final drawerContainer = Container(
      width: 300,
      padding: EdgeInsets.only(left: 16, right: 40),
      child: SafeArea(child: DrawerContent(currentRoute)),
    );

    final canvasColor = Theme.of(context).canvasColor;

    final baseColor = settingsModel.nightMode ? canvasColor : Colors.white;

    final transparentDecoration = BoxDecoration(
      color: baseColor.withOpacity(settingsModel.nightMode ? 0.6 : 0.9),
    );

    final transparentFilter = BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
      child: Container(decoration: transparentDecoration),
    );

    final transparentDrawerContainer = Stack(
      children: [transparentFilter, drawerContainer],
    );

    final drawerClipPath = ClipPath(
      clipper: DrawerClipper(),
      child: Drawer(child: transparentDrawerContainer),
    );

    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: drawerClipPath,
    );

  }
}
