import 'package:flutter/material.dart';
import 'package:letsattend/models/post.dart';
import 'package:letsattend/view_models/filterable_model.dart';
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

    final newsModel = Provider.of<FilterableModel>(context);

    final streamBuilder = StreamBuilder(
      stream: newsModel.stream,
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
      slivers: [sliverAppBar, streamBuilder],
    );

    return Scaffold(
      drawer: DrawerView(),
      body: customScroll,
      extendBodyBehindAppBar: true,
    );

  }

  Widget buildStream(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasError)
      return Center(child: Text('Error: ${snapshot.error}'));

    if(snapshot.hasData)
      return buildNews(context, snapshot.data);

    if (snapshot.connectionState == ConnectionState.waiting)
      return Center(child: CircularProgressIndicator());

    return Text('Nothing to show: ${snapshot.error}');
  }

  Widget buildNews(BuildContext context, List<Post> posts) {

    final sliverListDelegate = SliverChildBuilderDelegate(
      (context, itemIndex) => PostWidget(post: posts[itemIndex]),
      childCount: posts.length,
    );

    return SliverList(delegate: sliverListDelegate);

  }

}
