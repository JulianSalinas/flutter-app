import 'package:letsattend/locator.dart';
import 'package:letsattend/models/post.dart';
import 'package:letsattend/services/realtime/news_service.dart';
import 'package:letsattend/view_models/auth/auth_model.dart';
import 'package:letsattend/view_models/collections/news_model.dart';
import 'package:letsattend/views/news/news_view.dart';
import 'package:letsattend/views/news/post_widget.dart';
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

    AuthModel auth = Provider.of<AuthModel>(context);

    final temporal = CustomScrollView(
      slivers: <Widget>[
//          FlutterLogo(
//            size: 128,
//          ),
//          SizedBox(height: 32,),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              haccess(Icons.event, SharedColors.alizarin, () {
//                Navigator.pushReplacementNamed(context, Router.SCHEDULE_ROUTE);
//              }),
//              SizedBox(width: 8,),
//              access(Icons.people, SharedColors.midnightBlue, () {
//                Navigator.pushReplacementNamed(context, Router.SPEAKERS_ROUTE);
//              }),
//              SizedBox(width: 8,),
//              access(Ionicons.md_qr_scanner, SharedColors.midnightBlue, null),
//              SizedBox(width: 8,),
//              access(Icons.chat, SharedColors.midnightBlue, () {
//                Navigator.pushReplacementNamed(context, Router.CHAT_ROUTE);
//              }),
//            ],
//          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              haccess(Icons.power_settings_new, SharedColors.alizarin, () async {
//                await auth.signOut();
//              }),
//            ],
//          ),
//          SizedBox(height: 32,),
        ChangeNotifierProvider<NewsModel>(
          create: (context) => locator<NewsModel>(),
          child: Consumer(
            builder: (_, NewsModel model, __) {
              return StreamBuilder(
                stream: model.stream,
                builder: (_, AsyncSnapshot snapshot) {
                  if(snapshot.hasData) {
                    return buildNews(context, snapshot.data);
                  }
                  else {
                    return null;
                  }
                },
              );
            },
          ),
        ),
      ],
    );

    return Scaffold(
      drawer: DrawerView(Router.HOME_ROUTE),
      body: temporal,
    );

  }

  Widget buildNews(BuildContext context, List<Post> posts) {

    final postWidget = (_, itemIndex) => PostWidget(
      post: posts[itemIndex],
    );

    final sliverListDelegate = SliverChildBuilderDelegate(
      postWidget,
      childCount: posts.length,
    );

    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      sliver: SliverList(delegate: sliverListDelegate)
    );

  }

}
