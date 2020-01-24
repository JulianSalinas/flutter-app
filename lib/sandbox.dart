import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


void main() {
  runApp(MaterialApp(
    home: DarkDrawerPage(),
    theme: ThemeData.dark(),
  ));
}

class DarkDrawerPage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(title: Text('Drawer Navigation')),
      drawer: _buildDrawer(),
    );
  }

  _buildDrawer() {

    final String image = 'https://lh3.googleusercontent.com/a-/AAuE7mAmIi8rrtXWj7DRq0PgnmpWoXEdvYAXyrRXQw3LZA=s120-p-no';

    final drawerDecoration = BoxDecoration(
//      color: primary,
      gradient:  LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Color(0xff614385), Color(0xff516395)],
      ),
      boxShadow: [BoxShadow(color: Colors.black45)],
    );

    final closeSession = Container(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: Icon(Icons.power_settings_new),
        onPressed: () {},
      ),
    );

    final drawerAvatar = Container(
      height: 90,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.orange, Colors.deepOrange],
        ),
      ),
      child: CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(image),
      ),
    );

    final drawerUsername = Text(
      'Julian Salinas',
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
      ),
    );

    final drawerEmail = Text(
      'july12sali@gmail.com'
    );

    final drawerContent = SingleChildScrollView(
      child: Column(
        children: <Widget>[
          closeSession,
          drawerAvatar,
          SizedBox(height: 5.0),
          drawerUsername,
          drawerEmail,
          SizedBox(height: 30.0),
          _buildRow(Icons.home, 'Home'),
          _buildDivider(),
          _buildRow(Icons.person_pin, 'My profile'),
          _buildDivider(),
          _buildRow(Icons.message, 'Messages', showBadge: true),
          _buildDivider(),
          _buildRow(Icons.notifications, 'Notifications', showBadge: true),
          _buildDivider(),
          _buildRow(Icons.settings, 'Settings'),
          _buildDivider(),
          _buildRow(Icons.email, 'Contact us'),
          _buildDivider(),
          _buildRow(Icons.info_outline, 'Help'),
          _buildDivider(),
        ],
      ),
    );

    final drawer = Container(
      width: 300,
      padding: EdgeInsets.only(left: 16, right: 40),
      decoration: drawerDecoration,
      child: SafeArea(child: drawerContent),
    );

    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(child: drawer),
    );

  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRow(IconData icon, String title, {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          icon,
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
        Spacer(),
        if (showBadge)
          Material(
            color: Colors.deepOrange,
            elevation: 5.0,
            shadowColor: Colors.red,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              width: 25,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                '10+',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
      ]),
    );
  }

}


class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width-40, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height/2);
    path.quadraticBezierTo(
        size.width, size.height - (size.height / 4), size.width-40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}
