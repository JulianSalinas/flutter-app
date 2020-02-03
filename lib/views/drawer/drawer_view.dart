import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:letsattend/router.dart' as router;
import 'package:letsattend/view_models/theme_model.dart';
import 'package:letsattend/views/drawer/drawer_clipper.dart';
import 'package:letsattend/views/drawer/drawer_option.dart';
import 'package:provider/provider.dart';

class DrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeModel themeModel = Provider.of<ThemeModel>(context);

    final String image =
        'https://scontent.fsyq3-1.fna.fbcdn.net/v/t1.0-9/79015077_2307245962900839_6199160189350838272_n.jpg?_nc_cat=101&_nc_oc=AQnf8bZhKczAB8lws84ULduMhH4u2I0rnCoa3eAJ5CTfHlW0doN0uZzDZIT2iqn7d9U&_nc_ht=scontent.fsyq3-1.fna&oh=1f7d0595e5cb35ee2bd87713dc9996b8&oe=5E906E07';

    final closeSession = Container(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: Icon(Icons.power_settings_new),
        onPressed: () {},
      ),
    );

    final initials = Text(
      'JS',
      style: TextStyle(fontSize: 24, color: Colors.white),
    );

    final avatar = CircleAvatar(
      radius: 40,
      backgroundColor: Colors.purple,
      child: initials,
    );

    final drawerAvatar = Container(
      height: 90,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.red, Colors.orangeAccent],
        ),
      ),
      child: false
          ? avatar
          : CircleAvatar(
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

    final drawerEmail = Text('july12sali@gmail.com');

    final divider = Divider(
      color: Colors.grey.withOpacity(0.8),
    );

    final drawerContent = SingleChildScrollView(
      child: Column(
        children: <Widget>[
          closeSession,
          drawerAvatar,
          SizedBox(height: 12.0),
          drawerUsername,
          drawerEmail,
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
            showBadge: true,
          ),
          divider,
          DrawerOption(
            icon: Icons.notifications,
            title: 'Noticias',
            showBadge: true,
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
          ),
          divider,
          DrawerOption(
            icon: Icons.email,
            title: 'Contácto',
          ),
          divider,
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(MaterialCommunityIcons.weather_night),
                SizedBox(width: 12.0),
                Text(
                  'Modo oscuro',
                  style: TextStyle(fontSize: 16.0),
                ),
                Spacer(),
                Switch(
                  value: themeModel.nightMode,
                  onChanged: (bool active) => themeModel.nightMode = active,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final drawerContainer = Container(
      width: 300,
      padding: EdgeInsets.only(left: 16, right: 40),
      child: SafeArea(child: drawerContent),
    );

    final blurColor =
        themeModel.nightMode ? Theme.of(context).canvasColor : Colors.white;

    final blurDecoration = BoxDecoration(
      color: blurColor.withOpacity(themeModel.nightMode ? 0.6 : 0.9),
    );

    final blurBackdrop = BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
      child: Container(decoration: blurDecoration),
    );

    final blurDrawerContainer = Stack(
      children: [blurBackdrop, drawerContainer],
    );

    final drawerClipPath = ClipPath(
      clipper: DrawerClipper(),
      child: Drawer(child: blurDrawerContainer),
    );

    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: drawerClipPath,
    );
  }
}
