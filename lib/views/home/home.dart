import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:letsattend/router.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/widgets/night_switch.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:letsattend/view_models/settings_model.dart';

class Home extends StatefulWidget {

  @override
  HomeState createState() => HomeState();

}

/// A simple colored screen with a centered text
class HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    final settingsModel = Provider.of<SettingsModel>(context);

    final haccess = (IconData icon, Color color, Function onTap) => Material(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Icon(icon, color: Colors.white,),
        ),
      ),
      borderOnForeground: true,
      elevation: 16.0,
    );

    final access = (IconData icon, Color color, Function onTap) => Material(
      color: settingsModel.nightMode ? color : Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Icon(icon),
        ),
      ),
      borderOnForeground: false,
      elevation: 16.0,
    );

    final temporal = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FlutterLogo(
            size: 128,
          ),
          SizedBox(height: 32,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              haccess(Icons.event, SharedColors.alizarin, () {
                Navigator.pushReplacementNamed(context, Router.SCHEDULE_ROUTE);
              }),
              SizedBox(width: 8,),
              access(Icons.people, SharedColors.midnightBlue, () {
                Navigator.pushReplacementNamed(context, Router.SPEAKERS_ROUTE);
              }),
              SizedBox(width: 8,),
              access(Ionicons.md_qr_scanner, SharedColors.midnightBlue, null),
              SizedBox(width: 8,),
              access(Icons.chat, SharedColors.midnightBlue, () {
                Navigator.pushReplacementNamed(context, Router.CHAT_ROUTE);
              }),
            ],
          ),
          SizedBox(height: 32,),
//          News(),
        ],
      ),
    );

    return Scaffold(
      drawer: DrawerView(Router.HOME_ROUTE),
      body: Column(
        children: <Widget>[
          Expanded(child: temporal,),
          NightSwitch(),
        ],
      ),
    );

  }
}
