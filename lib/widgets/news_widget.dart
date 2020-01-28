import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/models/post.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/widgets/preview/touchable_preview.dart';

class NewsWidget extends StatelessWidget {

  final Post post;

  const NewsWidget({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final datetime = Text(
      'Hace 3 horas',
      style: TextStyle(
        fontSize: 12,
        color: SharedColors.peterRiver,
      ),
    );

    final preview = post.preview != null ?
      TouchablePreview(preview: post.preview) :
      SizedBox.shrink();

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        datetime,
        SizedBox(height: 2),
        Text(post.title, style: Typography.englishLike2018.title),
        SizedBox(height: 4,),
        Text(post.description),
        SizedBox(height: 8,),
        preview
      ],
    );

    final decoration = Container(
      width: 6,
      height: 6,
      margin: EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: SharedColors.peterRiver,
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
      margin: EdgeInsets.only(bottom: 16),
      child: container,
    );

  }

}