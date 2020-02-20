import 'package:flutter/material.dart';
import 'package:letsattend/models/post.dart';
import 'package:letsattend/router.dart';
import 'package:letsattend/view_models/collections/filterable_model.dart';
import 'package:letsattend/view_models/collections/news_model.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:letsattend/views/news/post_widget.dart';
import 'package:letsattend/widgets/flexible_space.dart';
import 'package:letsattend/widgets/modern_text.dart';
import 'package:provider/provider.dart';

class NewsView extends StatefulWidget {

  @override
  NewsViewState createState() => NewsViewState();

}

/// A simple colored screen with a centered text
class NewsViewState extends State<NewsView> {

  @override
  Widget build(BuildContext context) {

    final news = Provider.of<NewsModel>(context);

    final streamBuilder = StreamBuilder(
      stream: news.stream,
      builder: buildStream,
    );

    final sliverAppBar = SliverAppBar(
      title: ModernText('Noticias', color: Colors.white,),
      centerTitle: true,
      floating: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpace(),
    );

    final customScroll = CustomScrollView(
      slivers: <Widget>[sliverAppBar, streamBuilder],
    );

    return Scaffold(
      drawer: DrawerView(Router.NEWS_ROUTE),
      body: customScroll,
      extendBodyBehindAppBar: true,
    );

  }

  Widget buildStream(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasError)
      return SliverFillRemaining(child: Center(child: Text('Error: ${snapshot.error}')));

    if(snapshot.hasData)
      return buildNews(context, snapshot.data);

    if (snapshot.connectionState == ConnectionState.waiting)
      return SliverFillRemaining(child: Center(child: CircularProgressIndicator()));

    return SliverFillRemaining(child: Text('Nothing to show: ${snapshot.error}'));
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
