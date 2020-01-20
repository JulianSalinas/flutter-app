import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:letsattend/controllers/theme_controller.dart';
import 'package:letsattend/colors.dart';
import 'package:letsattend/widgets/night_switch.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {

  @override
  HomeState createState() => HomeState();

}

/// A simple colored screen with a centered text
class HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    final scheme = Provider.of<ThemeController>(context);

    final haccess = (IconData icon, Color color) => Material(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      child: InkWell(
        onTap: () => print('holis'),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Icon(icon, color: Colors.white,),
        ),
      ),
      borderOnForeground: true,
      elevation: 16.0,
    );

    final access = (IconData icon, Color color) => Material(
      color: scheme.nightMode ? color : Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      child: InkWell(
        onTap: () => print('holis'),
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
              haccess(Icons.event, FlatUI.alizarin),
              SizedBox(width: 8,),
              access(Icons.people, FlatUI.midnightBlue),
              SizedBox(width: 8,),
              access(Ionicons.md_qr_scanner, FlatUI.midnightBlue),
              SizedBox(width: 8,),
              access(Icons.chat, FlatUI.midnightBlue),
            ],
          ),
          SizedBox(height: 32,),
//          News(),
        ],
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(child: temporal,),
          NightSwitch(),
        ],
      ),
    );

  }
}
