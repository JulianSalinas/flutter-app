import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:jiffy/jiffy.dart';
import 'package:letsattend/models/post.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/widgets/common/browser_view.dart';
import 'package:letsattend/widgets/common/preview_image.dart';
import 'package:letsattend/widgets/common/preview_link.dart';

class PostWidget extends StatelessWidget {

  final Post post;

  PostWidget({
    required this.post,
  }) : super(key: Key(post.key));

  openUrl(BuildContext context, LinkableElement params) {
    final browser = BrowserView(initialUrl: params.url);
    final route = MaterialPageRoute(builder: (_) => browser);
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {

    final timeAgoStyle = TextStyle(
      fontSize: 12,
      color: SharedColors.peterRiver,
    );

    final timeAgoText = Text(
      Jiffy(post.timestamp).fromNow(),
      style: timeAgoStyle,
    );

    final title = post.title != null
        ? Text(
            post.title ?? 'bugtitle',
            style: Typography.englishLike2018.headline6,
          )
        : SizedBox.shrink();

    final description = post.description != null
        ? Linkify(
            text: post.description!,
            onOpen: (params) => openUrl(context, params),
          )
        : SizedBox.shrink();

    final preview = post.preview != null
        ? post.preview!.isImage()
            ? PreviewImage(imageUrl: post.preview!.url)
            : PreviewLink(preview: post.preview!)
        : SizedBox.shrink();

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        timeAgoText,
        SizedBox(height: 8),
        if (post.title != null) ...[
          title,
          SizedBox(height: 4),
        ],
        if (post.description != null) ...[
          description,
          SizedBox(height: 8),
        ],
        preview,
      ],
    );

    final decoration = BoxDecoration(
      color: SharedColors.peterRiver,
      shape: BoxShape.circle,
    );

    final decorationContainer = Container(
      width: 6,
      height: 6,
      margin: EdgeInsets.only(top: 4),
      decoration: decoration,
    );

    final container = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        decorationContainer,
        SizedBox(width: 8),
        Expanded(child: content),
      ],
    );

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: container,
    );
  }
}
