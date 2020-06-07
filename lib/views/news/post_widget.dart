import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:jiffy/jiffy.dart';
import 'package:letsattend/models/post.dart';
import 'package:letsattend/models/post.dart';
import 'package:letsattend/shared/utils.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/views/browser/browser_view.dart';
import 'package:letsattend/widgets/touchable/touchable_image.dart';
import 'package:letsattend/widgets/touchable/touchable_preview.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  PostWidget({
    Key key,
    @required this.post,
  }) : super(key: key ?? Key(post.key));

  @override
  Widget build(BuildContext context) {
    final timeAgoTextStyle = TextStyle(
      fontSize: 12,
      color: SharedColors.peterRiver,
    );

    final timeAgoText = Text(
      Jiffy(post.timestamp).fromNow(),
      style: timeAgoTextStyle,
    );

    final description = Linkify(
      text: post.description,
      onOpen: (params) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BrowserView(initialUrl: params.url)),
      ),
    );

    final preview = post.preview != null
        ? post.preview.isImage()
            ? TouchableImage(imageUrl: post.preview.url)
            : TouchablePreview(preview: post.preview)
        : SizedBox.shrink();

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        timeAgoText,
        SizedBox(height: 8),
        Text(post.title ?? 'bugtitle',
            style: Typography.englishLike2018.headline6),
        SizedBox(height: 4),
        description,
        SizedBox(height: 8),
        preview,
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
        SizedBox(width: 8),
        Expanded(child: content)
      ],
    );

    return Container(
//      height: 240,
      margin: EdgeInsets.only(bottom: 16),
      child: container,
    );
  }
}
