import 'package:flutter/material.dart';
import 'package:letsattend/models/post.dart';
import 'package:letsattend/models/preview.dart';
import 'package:letsattend/views/news/post_widget.dart';
import 'package:letsattend/widgets/night_switch.dart';
import 'package:letsattend/widgets/modern_text.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

class News extends StatefulWidget {

  @override
  NewsState createState() => NewsState();

}

/// A simple colored screen with a centered text
class NewsState extends State<News> {

  List<Post> news = <Post>[];

  @override
  void initState() {
    super.initState();
  }

  Widget buildItem(BuildContext context, int i){
    return PostWidget(post: news[i]);
  }

  @override
  Widget build(BuildContext context) {

    final listView = ListView.builder(
      padding:  EdgeInsets.fromLTRB(10, 16, 16, 16),
      itemBuilder: buildItem,
      itemCount: news.length
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(child: listView,),
          NightSwitch(),
        ],
      ),
      appBar: AppBar(
        title: ModernText('Noticias', color: Colors.white,),
        centerTitle: true,
      ),
    );

  }
}
