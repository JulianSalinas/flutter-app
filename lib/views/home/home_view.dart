import 'package:flutter/cupertino.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/models/post.dart';
import 'package:letsattend/services/news_service.dart';
import 'package:letsattend/blocs/auth/auth_bloc.dart';
import 'package:letsattend/blocs/news_bloc.dart';
import 'package:letsattend/views/home/home_carousel.dart';
import 'package:letsattend/views/home/home_circle.dart';
import 'package:letsattend/views/home/home_option.dart';
import 'package:letsattend/views/news/news_view.dart';
import 'package:letsattend/views/news/post_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:letsattend/router/routes.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:letsattend/blocs/settings_bloc.dart';

class HomeView extends StatefulWidget {

  @override
  HomeViewState createState() => HomeViewState();

}

/// A simple colored screen with a centered text
class HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {

//    final auth = Provider.of<AuthModel>(context);
//    final settings = Provider.of<SettingsModel>(context);
    final news = Provider.of<NewsBloc>(context);

    final logo = Hero(
      tag: 'app-logo',
      child: FlutterLogo(size: 132, colors: Colors.deepOrange),
    );

    final logoContainer = Container(
      padding: EdgeInsets.only(top: 48, bottom: 24),
      child: logo,
    );

    final optionsList = ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 8),
          child: HomeCircle(
            text: 'Cronograma',
            icon: Icon(Ionicons.md_calendar, size: 28),
            onTap: () => Navigator.of(context).pushReplacementNamed(Routes.SCHEDULE_ROUTE),
          ),
        ),
        HomeCircle(
          text: 'Expositores',
          icon: Icon(Icons.people, size: 28,),
          onTap: () => Navigator.of(context).pushReplacementNamed(Routes.SPEAKERS_ROUTE),
        ),
        HomeCircle(
          text: 'Mensajes',
          icon: Icon(Entypo.chat, size: 28,),
          onTap: () => Navigator.of(context).pushReplacementNamed(Routes.CHAT_ROUTE),
        ),
        HomeCircle(
          text: 'Configuración',
          icon: Icon(MaterialCommunityIcons.settings, size: 28,),
          onTap: () => Navigator.of(context).pushReplacementNamed(Routes.SETTINGS_ROUTE),
        ),
        Container(
          margin: EdgeInsets.only(right: 12),
          child: HomeCircle(
            text: 'Contácto',
            icon: Icon(Icons.mail, size: 28,),
            onTap: () => Navigator.of(context).pushReplacementNamed(Routes.ABOUT_ROUTE),
          ),
        ),
      ],
    );

    final subtitleStyle = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    );

    final optionsTitle = Container(
      margin: EdgeInsets.only(left: 16, bottom: 16),
      child: Text('Bienvenido', style: subtitleStyle),
    );

    final optionsContainer = Container(
      alignment: Alignment.center,
      height: 88,
      child: optionsList,
    );

    final newsTitle = Container(
      margin: EdgeInsets.only(left: 16, bottom: 16),
      child: Text('Noticias', style: subtitleStyle),
    );

//    final divider = Divider(
//      height: 48,
//      thickness: 2,
//      indent: 16,
//      endIndent: 16,
//    );

    final divider = SizedBox(height: 24,);

    final image = Image(
      image: AssetImage('assets/planning.png'),
    );

    final container = CustomScrollView(
      slivers: <Widget>[
//        SliverToBoxAdapter(child: logoContainer),
        SliverToBoxAdapter(child: optionsTitle),
        SliverToBoxAdapter(child: optionsContainer),
        SliverToBoxAdapter(child: divider),
        SliverToBoxAdapter(child: newsTitle),
        SliverToBoxAdapter(child: HomeCarousel()),
//        StreamBuilder(
//          stream: news.stream,
//          builder: (_, snapshot) {
//            if (snapshot.hasData){
//              return buildNews(_, snapshot.data);
//            }
//            return SliverToBoxAdapter(
//              child: Text('grte'),
//            );
//          },
//        ),
      ],
    );

    final paddedContent = Padding(
      padding: EdgeInsets.only(top: 32),
      child: container,
    );

    return Scaffold(
      drawer: DrawerView(Routes.HOME_ROUTE),
      body: SafeArea(child: paddedContent),
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
