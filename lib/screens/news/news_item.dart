import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/colors/flat_ui.dart';
import 'package:letsattend/models/post.dart';
import 'package:letsattend/providers/scheme.dart';
import 'package:letsattend/screens/news/news_preview.dart';
import 'package:provider/provider.dart';

class NewsItem extends StatelessWidget {

  final Post post;

  const NewsItem({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final scheme = Provider.of<Scheme>(context);

    final upper = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(post.title),
        Text('hace 1 hora')
      ],
    );

    final preview = post.preview != null ?
      NewsPreview(preview: post.preview) :
      SizedBox.shrink();

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(post.title, style: Typography.englishLike2018.title),
        SizedBox(height: 4,),
        Text(post.description),
        SizedBox(height: 8,),
        preview
      ],
    );

    final decoration = Container(
      width: 5,
      height: 5,
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: FlatUI.peterRiver,
        shape: BoxShape.circle,
      ),
    );

    final container = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        decoration,
        SizedBox(width: 8,),
        Expanded(child: content,)
      ],
    );

    return Container(
//      height: 240,
      child: container,
    );

  }

}